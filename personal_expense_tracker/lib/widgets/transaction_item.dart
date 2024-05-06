import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.purple,
        ),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () => deleteTx(transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTx(transaction.id),
                color: Colors.red,
              ),
      ),
    );
  }
}
