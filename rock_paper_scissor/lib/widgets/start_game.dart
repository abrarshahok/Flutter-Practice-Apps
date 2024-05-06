import 'package:flutter/material.dart';

class StartGame extends StatelessWidget {
  final VoidCallback startGame;

  const StartGame({required this.startGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: startGame,
            child: Text('Play Game'),
          ),
        ],
      ),
    );
  }
}
