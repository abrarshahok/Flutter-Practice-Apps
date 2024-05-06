import 'package:flutter/material.dart';
import '/widgets/add_new_task.dart';
import 'task_list.dart';
import '../models/tasks.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Tasks> _taskList = [];

  void _addNewTask({
    required String newtask,
    required DateTime date,
    required TimeOfDay time,
  }) {
    final newTask = Tasks(
      id: DateTime.now().toString(),
      task: newtask,
      dueDate: date,
      dueTime: time,
      isDone: false!,
    );
    setState(() {
      _taskList.add(newTask);
    });
  }

  void _startAddingTask(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddNewTask(addTask: _addNewTask);
        });
  }

  void _startDeleteTask(String id) {
    setState(() {
      _taskList.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO DO'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _startAddingTask(context),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskList(
              taskList: _taskList,
              deleteTask: _startDeleteTask,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddingTask(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
