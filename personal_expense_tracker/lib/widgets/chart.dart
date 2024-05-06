import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/widgets/chart_bars.dart';
import '/models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTx;
  Chart({required this.recentTx});
  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (int i = 0; i < recentTx.length; i++) {
        if (recentTx[i].date.day == weekDay.day &&
            recentTx[i].date.month == weekDay.month &&
            recentTx[i].date.year == weekDay.year) {
          totalSum += recentTx[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).toString().substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpendingPer {
    return groupedTxValues.fold(
        0.0, (sum, value) => sum + (value['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTxValues.map((data) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChartBars(
                label: data['day'] as String,
                spending: data['amount'] as double,
                totalSpendingPer: totalSpendingPer == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpendingPer,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
