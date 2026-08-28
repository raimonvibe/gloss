import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'branding.dart';
import 'data/word_repository.dart';
import 'screens/home_screen.dart';
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
        ChangeNotifierProvider(create: (_) => quiz ?? QuizController()),
        ChangeNotifierProvider(
          create: (_) => speech ?? SpeechController(),
        ),
        Provider.value(value: repository),
      ],
      child: Consumer<SettingsController>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: Branding.displayName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            home: const AppShell(),
          );
        },
      ),
    );
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
                  ),
                  const LexiconScreen(),
                  const QuizScreen(),
                  const LexiconScreen(favoritesOnly: true),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _selectTab,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'Lexicon',
                ),
                NavigationDestination(
                  icon: Icon(Icons.quiz_outlined),
                  selectedIcon: Icon(Icons.quiz),
                  label: 'Quiz',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: 'Saved',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
