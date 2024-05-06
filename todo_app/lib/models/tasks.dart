import 'package:flutter/material.dart';

class Tasks {
  final String id;
  final String task;
  final DateTime dueDate;
  final TimeOfDay dueTime;
  bool isDone;

  Tasks({
    required this.id,
    required this.task,
    required this.dueDate,
    required this.dueTime,
    required this.isDone,
  });
}
