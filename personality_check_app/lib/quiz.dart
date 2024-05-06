import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answerChoosed;
  final int qIndex;

  const Quiz({
    required this.questions,
    required this.answerChoosed,
    required this.qIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questionText: questions[qIndex]['qText'] as String,
        ),
        ...(questions[qIndex]['answer'] as List<Map<String, Object>>).map(
          (text) => Answer(
            answerText: text['text'] as String,
            onPressed: () => answerChoosed(text['score']),
          ),
        ),
      ],
    );
  }
}
