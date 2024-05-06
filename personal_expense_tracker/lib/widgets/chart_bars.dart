import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String label;
  final double spending;
  final double totalSpendingPer;

  const ChartBars({
    required this.label,
    required this.spending,
    required this.totalSpendingPer,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: [
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${spending.toStringAsFixed(0)}',
                  style: TextStyle(fontFamily: 'Quicksand'),
                ),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
              height: constraint.maxHeight * 0.6,
              width: 10,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: totalSpendingPer,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
