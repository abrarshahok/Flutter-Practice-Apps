import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int userScore;
  final int aiScore;
  final String WinnerText;
  final VoidCallback restart;

  const ResultScreen({
    required this.userScore,
    required this.aiScore,
    required this.WinnerText,
    required this.restart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Card(
          elevation: 8,
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Your Score',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$userScore',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'AI Score',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$aiScore',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$WinnerText',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                fixedSize: Size(100, 40),
              ),
              onPressed: restart,
              child: Text(
                'Restart',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
