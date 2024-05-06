import 'package:flutter/material.dart';
import '/widgets/game_screen.dart';
import '/widgets/start_game.dart';
import 'result_screen.dart';
import 'dart:math';

enum Choice { rock, paper, scissor }

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int moves = 0;
  var aiMove;
  var userMove;
  int aiScore = 0;
  int userScore = 0;

  void onRockPressed() {
    setState(() {
      userMove = Choice.rock;
      final genRandom = Random();
      final randomNum = genRandom.nextInt(3);
      aiMove = Choice.values[randomNum];
      checkWinner();
      moves++;
    });
  }

  void onPaperPressed() {
    setState(() {
      userMove = Choice.paper;
      final genRandom = Random();
      final randomNum = genRandom.nextInt(3);
      aiMove = Choice.values[randomNum];
      checkWinner();
      moves++;
    });
  }

  void onScissorPressed() {
    setState(() {
      userMove = Choice.scissor;
      final genRandom = Random();
      final randomNum = genRandom.nextInt(3);
      aiMove = Choice.values[randomNum];
      checkWinner();
      moves++;
    });
  }

  void checkWinner() {
    if (moves < 5) {
      if (userMove == aiMove) {
        return;
      } else if (userMove == Choice.rock && aiMove == Choice.scissor ||
          userMove == Choice.paper && aiMove == Choice.rock ||
          userMove == Choice.scissor && aiMove == Choice.paper) {
        userScore++;
      } else {
        aiScore++;
      }
    }
  }

  String get WinnerText {
    if (userScore > aiScore) {
      return 'Congratulations! You Won <3';
    } else if (aiScore > userScore) {
      return 'AI Won! Better Luck Next Time <3';
    }
    return 'It\'s a Tie!';
  }

  String get userChoiceText {
    if (userMove == Choice.rock) {
      return 'Rock';
    } else if (userMove == Choice.paper) {
      return 'Paper';
    } else if (userMove == Choice.scissor) {
      return 'Scissor';
    }
    return 'null';
  }

  String get aiChoiceText {
    if (aiMove == Choice.rock) {
      return 'Rock';
    } else if (aiMove == Choice.paper) {
      return 'Paper';
    } else if (aiMove == Choice.scissor) {
      return 'Scissor';
    }
    return 'null';
  }

  void restart() {
    setState(() {
      moves = 0;
      aiScore = 0;
      userScore = 0;
      aiMove = null;
      userMove = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Rock Paper Scissor'),
        centerTitle: true,
        elevation: 10,
      ),
      body: moves == 0
          ? StartGame(
              startGame: () => setState(() {
                moves++;
              }),
            )
          : moves <= 5
              ? GameScreen(
                  moves: moves,
                  onRockPressed: onRockPressed,
                  onPaperPressed: onPaperPressed,
                  onScissorPressed: onScissorPressed,
                  userChoiceText: userChoiceText,
                  aiChoiceText: aiChoiceText,
                )
              : ResultScreen(
                  userScore: userScore,
                  aiScore: aiScore,
                  WinnerText: WinnerText,
                  restart: restart,
                ),
    );
  }
}
