import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback showDatePicker;
  final String text;
  const AdaptiveFlatButton({required this.showDatePicker,required this.text});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: showDatePicker,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: showDatePicker,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
