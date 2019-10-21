import 'package:flutter/material.dart';

import 'package:airbank/widgets/transaction_list_item.dart';
import 'package:airbank/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.6,
      child: transactions.isEmpty
          ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: <Widget>[
                  Text(
                    'No transactions were found',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return new TransactionListItem(
                  transaction: transactions[index],
                  mediaQuery: mediaQuery,
                  deleteTransaction: deleteTransaction
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
