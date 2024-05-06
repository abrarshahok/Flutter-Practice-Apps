import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/features/cart/screens/cart.dart';
import '/features/home/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {
        Cart.routeName: (context) =>  Cart(),
        
      },
    );
  }
}
