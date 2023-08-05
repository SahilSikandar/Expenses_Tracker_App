import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'chart.dart';
import 'new_transactions.dart';
import 'transaction_List.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.dateTime!
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTransaction = Transaction(
        name: txTitle,
        id: DateTime.now().toString(),
        price: txAmount,
        dateTime: choosenDate);
    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.yellow[200],
      context: context,
      builder: (ctx) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction));
      },
    );
  }

  double fabSize = 56.0;
  bool isFabExpanded = false;

  void _toggleFab() {
    setState(() {
      if (isFabExpanded) {
        fabSize = 56.0;
      } else {
        fabSize = 120.0;
      }
      isFabExpanded = !isFabExpanded;
    });
  }

  void _deleteCard(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
//    bool _showChart = false;
    final mediaQuery = MediaQuery.of(context);
    final appbar = AppBar(
      actions: [
        IconButton(
            onPressed: () {
              _showModalBottomSheet(context);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ))
      ],
      elevation: 1,
      backgroundColor: Colors.yellow[500],
      centerTitle: true,
      title: Text(
        "Expenses Tracker",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
    final _txList = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TrasnactionList(_userTransaction, _deleteCard));
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: ChartCard(_recentTransaction)),
            if (!isLandscape) _txList,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: ChartCard(_recentTransaction))
                  : _txList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: fabSize,
        height: 56.0,
        child: FloatingActionButton(
          onPressed: () {
            _showModalBottomSheet(context);
          },
          backgroundColor: Colors.yellow,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            firstChild: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            secondChild: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            crossFadeState: isFabExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ),
      ),
    );
  }
}
