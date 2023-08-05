import 'package:expense_tracker_app/models/transaction.dart';
import 'package:expense_tracker_app/widgets/bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartCard extends StatelessWidget {
  List<Transaction> recentTransaction;
  ChartCard(this.recentTransaction);
  // const ChartCard({super.key});
  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sumAmount = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime!.day == weekDay.day &&
            recentTransaction[i].dateTime!.month == weekDay.month &&
            recentTransaction[i].dateTime!.year == weekDay.year) {
          sumAmount += recentTransaction[i].price!;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(sumAmount);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': sumAmount
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Flexible(
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: groupedTransactionValues.map((e) {
              return Bars(
                  e['day'],
                  e['amount'],
                  maxSpending == 0.0
                      ? 0.0
                      : (e['amount'] / maxSpending as double));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
