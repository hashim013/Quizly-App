import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback restartQuiz;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.restartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Quiz Completed!",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Your Score: $score / $total",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: restartQuiz,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text(
              "Restart Quiz",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
