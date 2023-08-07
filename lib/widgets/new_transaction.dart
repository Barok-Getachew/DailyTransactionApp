import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  DateTime _selectedDate = DateTime.now();
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if ((pickedDate) == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(children: [
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  // onChanged: (value) => inputTitle = value,
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) => inputAmount = value,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        // ignore: unnecessary_null_comparison
                        _selectedDate == null
                            ? 'No Date Choosen'
                            : 'pickedDate: ${DateFormat.yMd().format(_selectedDate)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                // ignore: prefer_const_constructors
                padding: EdgeInsets.only(left: 50),
                child: ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    'Add transaction',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
