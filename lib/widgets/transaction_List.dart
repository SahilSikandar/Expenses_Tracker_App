import 'package:expense_tracker_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../utilis/constants.dart';

class TrasnactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteFunc;
  const TrasnactionList(this.transaction, this.deleteFunc);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Center(
            child: Text(
              "No Transaction Added yet",
              style: kh3,
            ),
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.all(10),
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    //color: Colors.yellow[500],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Card(
                    color: Colors.yellow[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 90,
                            child: FittedBox(
                              child: Text(
                                'Rs:${transaction[index].price!.toStringAsFixed(0)}',
                                style: TextStyle(
                                  //fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //radius: 20,
                          ),
                          title: Text(
                            transaction[index].name.toString(),
                            style: kh1,
                          ),
                          subtitle: Text(
                            DateFormat.E().add_yMMMd().format(
                                transaction[index].dateTime as DateTime),
                          ),
                          trailing: MediaQuery.of(context).size.width > 460
                              ? TextButton.icon(
                                  onPressed: () => deleteFunc(
                                      transaction[index].id.toString()),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: Text("Delete"))
                              : IconButton(
                                  onPressed: () => deleteFunc(
                                      transaction[index].id.toString()),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ))),
                    ),
                  ));
            },
          );
  }
}
