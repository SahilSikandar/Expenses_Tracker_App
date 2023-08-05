import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Bars extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingamount;
  const Bars(this.label, this.amount, this.spendingamount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: constraints.maxHeight * 0.1,
              child: Expanded(
                  child: FittedBox(
                      child: Text('Rs: ${amount.toStringAsFixed(0)}')))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.4,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingamount,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius:
                          BorderRadius.circular(constraints.maxHeight * 0.12)),
                ),
              )
            ]),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
