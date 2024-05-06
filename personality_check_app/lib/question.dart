import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  const Question({
    required this.questionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
