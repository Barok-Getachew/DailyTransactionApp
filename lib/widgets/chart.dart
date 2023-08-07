import 'package:flutter/material.dart';
import 'package:second_project/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<transaction> recentTransactinons;
  Chart(this.recentTransactinons);
  List<Map<String, Object>> get groupedtransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactinons.length; i++) {
        if (recentTransactinons[i].date.day == weekDay.day &&
            recentTransactinons[i].date.month == weekDay.month &&
            recentTransactinons[i].date.year == weekDay.year) {
          totalSum += recentTransactinons[i].amount;
        }
      }

      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedtransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedtransactionValues);
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionValues.map((recent) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  (recent['Day'] as String),
                  (recent['amount'] as double),
                  totalSpending == 0.0
                      ? 0.0
                      : (recent['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
