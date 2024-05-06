import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTask extends StatefulWidget {
  final Function addTask;

  const AddNewTask({required this.addTask});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final _taskController = TextEditingController();
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;
  void _submitData() {
    if (_taskController.text.isEmpty) {
      return;
    }
    widget.addTask(
      newtask: _taskController.text,
      date: _pickedDate,
      time: _pickedTime,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = date;
      });
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(date),
      ).then((time) {
        if (time == null) {
          return;
        }
        setState(() {
          _pickedTime = time;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Task',
              ),
              controller: _taskController,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _pickedDate == null
                        ? 'No date choosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_pickedDate!)}\nPicked Time: ${_pickedTime?.format(context)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text('Choose Date'),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}
