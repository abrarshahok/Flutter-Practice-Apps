import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/widgets/new_transactions.dart';
import '../models/transaction.dart';
import 'transaction_list.dart';
import 'chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTx {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTx({
    required String title,
    required double amount,
    required DateTime dateTime,
  }) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: dateTime,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(addTx: _addNewTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expense',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTx(context),
                )
              ],
            ),
          )
        : AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.purple,
            title: Text(
              'Personal Expense',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTx(context),
                icon: Icon(Icons.add),
              ),
            ],
          );

    final _showTransactionList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.75,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );

    final _showSwitch = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Show Chart',
          style: TextStyle(fontFamily: 'Quicksand'),
        ),
        Switch.adaptive(
          activeColor: Colors.amber,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    );

    Widget _showChartWidget(double n) {
      return Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            n,
        child: Chart(
          recentTx: _recentTx,
        ),
      );
    }

    List<Widget> _showOnLandscape() {
      return [
        _showSwitch,
        _showChart ? _showChartWidget(0.7) : _showTransactionList,
      ];
    }

    List<Widget> _showOnPotrait() {
      return [
        _showChartWidget(0.25),
        _showTransactionList,
      ];
    }

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape) ..._showOnLandscape(),
            if (!isLandscape) ..._showOnPotrait(),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () => _startAddNewTx(context),
                  ),
          );
  }
}
