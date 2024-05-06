import 'package:flutter/material.dart';
import 'calc_UI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 50,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 32,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
      ),
      title: 'Calculator',
      home: CalculatorUI(),
    );
  }
}
