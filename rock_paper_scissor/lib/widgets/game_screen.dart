import 'package:flutter/material.dart';
import '../buttons/custom_button.dart';

class GameScreen extends StatelessWidget {
  final int moves;
  final VoidCallback onRockPressed;
  final VoidCallback onPaperPressed;
  final VoidCallback onScissorPressed;
  final String userChoiceText;
  final String aiChoiceText;

  const GameScreen({
    required this.moves,
    required this.onRockPressed,
    required this.onPaperPressed,
    required this.onScissorPressed,
    required this.userChoiceText,
    required this.aiChoiceText,
  });

  final String rock = 'assets/images/rock.png';
  final String paper = 'assets/images/paper.png';
  final String scissor = 'assets/images/scissors.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You have ${6 - moves} Moves Left',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Card(
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: onRockPressed,
                  name: rock,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: onPaperPressed,
                  name: paper,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: onScissorPressed,
                  name: scissor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 8,
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'You Choosed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$userChoiceText',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'AI Choosed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$aiChoiceText',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
