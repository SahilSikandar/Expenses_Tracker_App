import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../utilis/constants.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;

  NewTransaction(this.newTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  void _onSubmit() {
    String title = _titleController.text;
    String amountText = _amountController.text;
    double amount = double.tryParse(amountText) ?? -1;

    if (title.isEmpty) {
      _showSnackbar('Please enter a name/title.');
    } else if (amount <= 0) {
      _showSnackbar('Please enter a valid amount.');
    } else if (_selectedDate == null) {
      _showSnackbar('Date is not Selected');
    } else {
      widget.newTx(title, amount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _showSnackbar(String message) {
    Get.snackbar('Alert', message,
        backgroundColor: Colors.red, duration: Duration(seconds: 3));
  }

  void _showSelectedDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101))
        .then((value) {
      if (value == null) {
        //Get.snackbar('Alert', "Select the Date");
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //dragStartBehavior: DragStartBehavior.start,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ]),
        margin: EdgeInsets.all(15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //margin: EdgeInsets.all(15),
          color: Colors.yellow,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 50),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  textInputAction: TextInputAction.next,
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    label: Text('Title'),
                    hoverColor: Colors.yellow,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) => _showSelectedDate(),
                  controller: _amountController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    label: Text('Amount'),
                    hoverColor: Colors.yellow,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate ==
                            null //ternary expression to check if date is null
                        ? 'No date was chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          _showSelectedDate();
                        },
                        child: Text('Add Date')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow[200],
                  ),
                  child: TextButton(
                      onPressed: () {
                        _onSubmit();
                      },
                      child: Text(
                        'Add to list',
                        style: kh3,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
