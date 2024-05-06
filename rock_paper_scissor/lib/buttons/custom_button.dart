import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  const CustomButton({required this.onPressed, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey[300],
      child: IconButton(
        splashColor: Colors.grey,
        constraints: BoxConstraints.expand(
          width: 100,
          height: 100,
        ),
        onPressed: onPressed,
        icon: Image.asset(
          name,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
