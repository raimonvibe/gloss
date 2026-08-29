import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'branding.dart';
import 'data/word_repository.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/study_screen.dart';
import 'screens/lexicon_screen.dart';
import 'screens/quiz_screen.dart';
import 'state/progress_controller.dart';
import 'state/quiz_controller.dart';
import 'state/settings_controller.dart';
import 'state/speech_controller.dart';
import 'theme/app_theme.dart';
import 'theme/layout.dart';
import 'widgets/ornament.dart';

class GlossApp extends StatelessWidget {
  const GlossApp({
    super.key,
    required this.settings,
    required this.progress,
    required this.repository,
    this.quiz,
    this.speech,
  });

  final SettingsController settings;
  final ProgressController progress;
  final WordRepository repository;
  final QuizController? quiz;
  final SpeechController? speech;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: progress),
        ChangeNotifierProvider.value(value: repository),
        ChangeNotifierProvider(create: (_) => quiz ?? QuizController()),
        ChangeNotifierProvider(
          create: (_) => speech ?? SpeechController(),
        ),
      ],
      child: Consumer<SettingsController>(
        builder: (context, settings, _) {
          final devices = View.maybeOf(context)?.platformDispatcher.locales ??
              WidgetsBinding.instance.platformDispatcher.locales;
          return MaterialApp(
            title: Branding.displayName,
            debugShowCheckedModeBanner: false,
            locale: settings.localeFor(devices),
            supportedLocales: settings.catalog.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            // The reader's choice multiplies the platform's own setting, so
            // someone who has already enlarged text system-wide keeps it —
            // capped, because past 2x the parchment cards start to clip.
            builder: (context, child) {
              final media = MediaQuery.of(context);
              final combined = media.textScaler.scale(1) * settings.textScale;
              return MediaQuery(
                data: media.copyWith(
                  textScaler: TextScaler.linear(combined.clamp(1.0, 2.0)),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: const _LocaleBinder(child: AppShell()),
          );
        },
      ),
    );
  }
}

class _LocaleBinder extends StatefulWidget {
  const _LocaleBinder({required this.child});

  final Widget child;

  @override
  State<_LocaleBinder> createState() => _LocaleBinderState();
}

class _LocaleBinderState extends State<_LocaleBinder> {
  String? _applied;
  var _voiceApplied = false;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    if (!_voiceApplied) {
      _voiceApplied = true;
      final speech = context.read<SpeechController>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        speech.applyPreferences(
          voiceName: settings.voiceName,
          rate: settings.speechRate,
        );
      });
    }
    final devices = View.of(context).platformDispatcher.locales;
    final key = settings.translationKeyFor(devices);
    if (_applied != key) {
      _applied = key;
      final repo = context.read<WordRepository>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        repo.applyLocale(key);
      });
    }
    return widget.child;
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with WidgetsBindingObserver {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      context.read<SpeechController>().stop();
    }
  }

  void _selectTab(int value) {
    if (value != _index) {
      context.read<SpeechController>().stop();
    }
    setState(() => _index = value);
  }

  /// One list of tabs, worn two ways: along the bottom on a phone, down the
  /// side once the page is wide enough to spare the width.
  List<_Destination> _destinations(AppLocalizations l10n) => [
        _Destination(Icons.home_outlined, Icons.home, l10n.navHome),
        _Destination(
          Icons.menu_book_outlined,
          Icons.menu_book,
          l10n.navLexicon,
        ),
        _Destination(Icons.quiz_outlined, Icons.quiz, l10n.navQuiz),
        _Destination(Icons.favorite_border, Icons.favorite, l10n.navSaved),
        _Destination(
          Icons.auto_stories_outlined,
          Icons.auto_stories,
          l10n.navStudy,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destinations = _destinations(l10n);
    final pages = LayoutBoundary(
      child: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            onOpenLexicon: () => _selectTab(1),
            onOpenQuiz: () => _selectTab(2),
            onOpenStudy: () => _selectTab(4),
          ),
          const LexiconScreen(),
          const QuizScreen(),
          const LexiconScreen(favoritesOnly: true),
          const StudyScreen(),
        ],
      ),
    );

    return PaperBackdrop(
      child: Stack(
        children: [
          const FlourishCorners(),
          LayoutBuilder(
            builder: (context, constraints) {
              final shell = Layout.fromConstraints(constraints);
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: shell.usesRail
                      ? Row(
                          children: [
                            _Rail(
                              index: _index,
                              onSelect: _selectTab,
                              extended: shell.usesExtendedRail,
                              destinations: destinations,
                            ),
                            Expanded(child: pages),
                          ],
                        )
                      : pages,
                ),
                bottomNavigationBar: shell.usesRail
                    ? null
                    : _TabBar(
                        index: _index,
                        onSelect: _selectTab,
                        width: shell.width,
                        destinations: destinations,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Navigation labels never grow past this, whatever the reader has asked
/// for elsewhere. It is the cap [NavigationBar] applies to its own labels.
const double _kLabelScaleCap = 1.3;

/// The size at which the longest of [labels] still sits on one line inside
/// [budget]. Never larger than the style asks for, and as small as it has
/// to be — a name too small to read still says more than one cut in half,
/// and hiding the labels would say nothing at all.
///
/// The tabs are drawn by [NavigationBar] as plain [Text] with no line limit,
/// and their labels are Strings rather than widgets — so the size they are
/// drawn at is the only thing that can be adjusted. German is what forces
/// this: "Saved" becomes "Gespeichert", which does not fit a fifth of a
/// phone, wraps, and is then cut off by the bar.
double _labelSizeThatFits(
  BuildContext context, {
  required List<String> labels,
  required TextStyle style,
  required double budget,
}) {
  final scaler = MediaQuery.textScalerOf(context).clamp(
    maxScaleFactor: _kLabelScaleCap,
  );
  final direction = Directionality.of(context);
  var size = style.fontSize ?? 12;
  for (final label in labels) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: style.copyWith(fontSize: size)),
      textDirection: direction,
      textScaler: scaler,
      maxLines: 1,
    )..layout();
    if (painter.width > budget) {
      // Text width tracks the font size closely enough for one pass.
      size *= budget / painter.width;
    }
  }
  return size;
}

/// The tabs along the bottom of a phone.
class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.index,
    required this.onSelect,
    required this.width,
    required this.destinations,
  });

  final int index;
  final ValueChanged<int> onSelect;
  final double width;
  final List<_Destination> destinations;

  @override
  Widget build(BuildContext context) {
    final barTheme = NavigationBarTheme.of(context);
    final base = barTheme.labelTextStyle?.resolve(const <WidgetState>{}) ??
        const TextStyle(fontSize: 12);
    // Each tab gets an equal share of the bar, less the padding either side
    // of its label.
    final fitted = _labelSizeThatFits(
      context,
      labels: [for (final tab in destinations) tab.label],
      style: base,
      budget: width / destinations.length - 12,
    );

    return NavigationBarTheme(
      data: barTheme.copyWith(
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) =>
              (barTheme.labelTextStyle?.resolve(states) ?? base).copyWith(
            fontSize: fitted,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onSelect,
        destinations: [
          for (final tab in destinations)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

/// The tabs down the side of a wide window.
///
/// A rail is a Column and will not scroll on its own, so five destinations at
/// the largest text size would run off the bottom of a short window. Giving
/// it a scroll view and a minimum height of the window keeps it whole.
class _Rail extends StatelessWidget {
  const _Rail({
    required this.index,
    required this.onSelect,
    required this.extended,
    required this.destinations,
  });

  final int index;
  final ValueChanged<int> onSelect;
  final bool extended;
  final List<_Destination> destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              selectedIndex: index,
              onDestinationSelected: onSelect,
              extended: extended,
              labelType: extended ? null : NavigationRailLabelType.all,
              destinations: [
                for (final tab in destinations)
                  NavigationRailDestination(
                    icon: Icon(tab.icon),
                    selectedIcon: Icon(tab.selectedIcon),
                    // A narrow rail is barely wider than "Gespeichert". Here
                    // the label is a widget, so it can simply be told to
                    // shrink rather than wrap.
                    label: extended
                        ? Text(tab.label)
                        : SizedBox(
                            width: 64,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                tab.label,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination(this.icon, this.selectedIcon, this.label);

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
