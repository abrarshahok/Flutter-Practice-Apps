import 'package:flutter/material.dart';

import 'widgets/my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
