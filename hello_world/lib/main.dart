import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
