import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airbank/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2
                    )
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    transactions[index].amount.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      )
                    )
                  ],
                )
              ],
            )
          );
        },
        itemCount: transactions.length,
        // children: transactions.map((tx) {
        //   return Card(
        //     child: Row(
        //       children: <Widget>[
        //         Container(
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               color: Colors.purple,
        //               width: 2
        //             )
        //           ),
        //           margin: EdgeInsets.symmetric(
        //             vertical: 10,
        //             horizontal: 15,
        //           ),
        //           padding: EdgeInsets.all(10),
        //           child: Text(
        //             tx.amount.toString(),
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 20,
        //               color: Colors.purple
        //             ),
        //           ),
        //         ),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Text(
        //               tx.title,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 16
        //               ),
        //             ),
        //             Text(
        //               DateFormat.yMMMd().format(tx.date),
        //               style: TextStyle(
        //                 color: Colors.grey,
        //               )
        //             )
        //           ],
        //         )
        //       ],
        //     )
        //   );
        // }).toList()
      ),
    );
  }
}