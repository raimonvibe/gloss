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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PaperBackdrop(
      child: Stack(
        children: [
          const FlourishCorners(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
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
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _selectTab,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: l10n.navHome,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.menu_book_outlined),
                  selectedIcon: const Icon(Icons.menu_book),
                  label: l10n.navLexicon,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.quiz_outlined),
                  selectedIcon: const Icon(Icons.quiz),
                  label: l10n.navQuiz,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.favorite_border),
                  selectedIcon: const Icon(Icons.favorite),
                  label: l10n.navSaved,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.auto_stories_outlined),
                  selectedIcon: const Icon(Icons.auto_stories),
                  label: l10n.navStudy,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
