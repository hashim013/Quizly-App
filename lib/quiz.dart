import 'package:quizly_app/screens/questions_screen.dart';
import 'package:quizly_app/screens/start_screen.dart';
import 'package:quizly_app/screens/result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen; // using widget as a variable, activescreen can be null
  int score = 0;
  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(switchScreen);
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(onQuizComplete);
    });
  }

  void onQuizComplete(int finalScore, int totalQuestions) {
    setState(() {
      score = finalScore;
      activeScreen = ResultScreen(
        score: score,
        total: totalQuestions,
        restartQuiz: restartQuiz,
      );
    });
  }

  void restartQuiz() {
    setState(() {
      score = 0;
      activeScreen = StartScreen(switchScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),

      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isDarkMode
                  ? [
                      const Color.fromARGB(255, 10, 112, 114),
                      const Color.fromARGB(255, 0, 0, 0),
                    ]
                  : [
                      const Color.fromARGB(255, 40, 199, 172),
                      const Color.fromARGB(255, 255, 255, 255),
                    ],
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
