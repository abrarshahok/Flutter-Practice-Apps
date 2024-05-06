import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tasks.dart';

class TaskList extends StatefulWidget {
  final List<Tasks> taskList;
  final Function deleteTask;
  TaskList({required this.taskList, required this.deleteTask});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final currentTime = TimeOfDay.now();
  final currentDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 710,
      child: widget.taskList.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'No tasks added yet!',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  Image.asset(
                    'assets/images/waiting.png',
                    height: 300,
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '  All ToDos',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.taskList.length,
                    itemBuilder: (ctx, index) {
                      Tasks task = widget.taskList[index];
                      bool isDone = task.isDone;

                      return Card(
                        elevation: 8,
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  task.isDone = !isDone;
                                });
                              },
                              icon: Icon(
                                isDone
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                              ),
                              color: Colors.purple,
                            ),
                            title: Text(
                              task.task,
                              style: TextStyle(
                                decoration: (task.isDone) ||
                                        (task.dueDate
                                                .isBefore(currentDateTime) &&
                                            ((task.dueTime.hour <
                                                    currentTime.hour &&
                                                task.dueTime.minute <
                                                    currentTime.minute)))
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Colors.red,
                                decorationThickness: 2.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              'Due: ${DateFormat.yMMMd().format(task.dueDate)} at ${task.dueTime.format(context)}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  isDone ? widget.deleteTask(task.id) : null,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
