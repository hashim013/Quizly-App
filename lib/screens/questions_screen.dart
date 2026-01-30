import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function(int score, int totalQuestions) onQuizComplete;

  const QuestionsScreen(this.onQuizComplete, {super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final List<Map<String, Object>> _questions = [
    {
      "question": "What is Flutter?",
      "options": ["Framework", "Library", "Language", "Compiler"],
      "answer": "Framework",
    },
    {
      "question": "Which language is used in Flutter?",
      "options": ["Java", "Dart", "Kotlin", "Swift"],
      "answer": "Dart",
    },
    {
      "question": "Who developed Flutter?",
      "options": ["Google", "Microsoft", "Apple", "IBM"],
      "answer": "Google",
    },
    {
      "question": "What does the setState() method do in Flutter?",
      "options": [
        "Deletes the current widget",
        "Updates the UI when the state changes",
        "Navigates to another screen",
        "Initializes a widget",
      ],
      "answer": "Updates the UI when the state changes",
    },
    {
      "question":
          "What is the root widget of a Flutter app that uses Material Design?",
      "options": ["AppBar", "Scaffold", "MaterialApp", "Container"],
      "answer": "MaterialApp",
    },
    {
      "question":
          "Which widget is used to arrange widgets vertically in Flutter?",
      "options": ["Row", "Column", "Stack", "ListView"],
      "answer": "Column",
    },
    {
      "question": "Which file is used to add assets and dependencies?",
      "options": ["main.dart", "pubspec.yaml", "android.xml", "config.json"],
      "answer": "pubspec.yaml",
    },
    {
      "question": "Which widget expands to fill the available space?",
      "options": ["SizedBox", "Expanded", "Center", "Padding"],
      "answer": "Expanded",
    },
    {
      "question": "What is the entry point function of a Flutter app?",
      "options": ["runApp()", "main()", "build()", "initState()"],
      "answer": "main()",
    },
    {
      "question":
          "Which widget allows you to stack elements on top of each other?",
      "options": ["Column", "Row", "Stack", "Expanded"],
      "answer": "Stack",
    },
  ];

  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;

  void _checkAnswer(String option) {
    setState(() {
      selectedAnswer = option;
      if (option == _questions[currentIndex]["answer"]) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentIndex < _questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
      });
    } else {
      widget.onQuizComplete(score, _questions.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[currentIndex];
    final options = currentQ["options"] as List<String>;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Q${currentIndex + 1}: ${currentQ["question"]}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(height: 20),

              ...options.map((option) {
                Color optionColor = Colors.white;
                if (selectedAnswer != null) {
                  if (option == currentQ["answer"]) {
                    optionColor = Colors.green.shade500;
                  } else if (option == selectedAnswer) {
                    optionColor = Colors.red.shade500;
                  }
                }

                return GestureDetector(
                  onTap: selectedAnswer == null
                      ? () => _checkAnswer(option)
                      : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: selectedAnswer != null ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: Text(
                  currentIndex == _questions.length - 1 ? "Finish" : "Next",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
