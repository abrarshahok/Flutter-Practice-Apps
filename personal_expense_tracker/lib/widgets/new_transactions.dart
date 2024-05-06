import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/widgets/adaptive_flat_button.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions({required this.addTx});

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _pickedDate == null) {
      return;
    }
    widget.addTx(
      title: enteredTitle,
      amount: enteredAmount,
      dateTime: _pickedDate,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                style: TextStyle(fontFamily: 'Quicksand'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                style: TextStyle(fontFamily: 'Quicksand'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _pickedDate == null
                            ? 'No Date Choosen!'
                            : 'Choosed Date: ${DateFormat.yMd().format(_pickedDate!)}',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    AdaptiveFlatButton(
                      text: 'Choose Date',
                      showDatePicker: _showDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
