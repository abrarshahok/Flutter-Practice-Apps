import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int result;
  final VoidCallback restartQuiz;
  const Result({required this.result, required this.restartQuiz});

  String get resultPhrase {
    if (result <= 8) {
      return 'You are Awesome and inoccent';
    } else if (result <= 12) {
      return 'Pretty Likeable';
    } else if (result <= 16) {
      return 'You are ... Strange';
    }
    return 'You are so bad';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '$resultPhrase\nScore: $result',
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: restartQuiz,
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }
}
