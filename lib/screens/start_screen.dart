import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/Quiz.png', width: 300, height: 300),
          const SizedBox(height: 30),
          Text(
            'Turn Practice into Progress!',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
              side: BorderSide(
                color: Theme.of(context).textTheme.bodyMedium!.color!,
              ),
            ),
            onPressed: startQuiz,
            child: Text(
              'Start Quiz',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
