import 'dart:math';

import 'package:flutter/material.dart';
import 'package:second_project/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  @override
  final Function delete;
  final List<transaction> transactions;
  TransactionList(this.delete, this.transactions);

  Widget build(BuildContext context) {
    return transactions.isEmpty
        // ignore: sized_box_for_whitespace
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                // ignore: prefer_const_constructors
                Text('No Transactions yet'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'Assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(index),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'QuickSand',
                          fontSize: 18),
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? TextButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            onPressed: () => delete(transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => delete(transactions[index].id),
                          ),
                  ));
            },
            itemCount: transactions.length,
          );
    // it maps
    //rathe instantiated object to the widjets
    Random();
  }
}
