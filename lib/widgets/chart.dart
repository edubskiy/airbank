import 'package:airbank/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airbank/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get grouppedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        var rtx = recentTransactions[i];
        if (rtx.date.day == weekDay.day && rtx.date.month == weekDay.month 
          && rtx.date.year == weekDay.year) {
            totalSum += rtx.amount;
          }
      }

      return { 
        'day': DateFormat.E().format(weekDay), 
        'amount': totalSum 
      };
    });
  }

  double get totalSpending {
    return grouppedTransactions.fold(0.0, (sum, item) {
        return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(grouppedTransactions);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Row(
        children: grouppedTransactions.map((tx) {
          return ChartBar(tx['day'], tx['amount'], (tx['amount'] as double) / totalSpending);
        }).toList()
    ));
  }
}
