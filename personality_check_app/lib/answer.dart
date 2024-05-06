import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback onPressed;
  Answer({
    required this.answerText,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(answerText),
      ),
    );
  }
}
