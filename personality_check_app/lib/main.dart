import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';
import 'QNA.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _qIndex = 0;
  int _totalScore = 0;
  void _answerChoosed(int score) {
    _totalScore += score;
    setState(() {
      _qIndex++;
    });
  }

  void _restart() => setState(() {
        _qIndex = 0;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personality Check'),
        ),
        body: _qIndex < questions.length
            ? Quiz(
                questions: questions,
                answerChoosed: _answerChoosed,
                qIndex: _qIndex,
              )
            : Result(
                result: _totalScore,
                restartQuiz: _restart,
              ),
      ),
    );
  }
}
