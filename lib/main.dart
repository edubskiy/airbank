import 'package:airbank/widgets/new_transaction.dart';
import 'package:airbank/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AirBank',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      title: title, 
      amount: amount, 
      date: DateTime.now(), 
      id: DateTime.now().toString()
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 69.99,
      date: DateTime.now()
    ),
    Transaction(
      id: 't2',
      title: 'Weekly casual groceries',
      amount: 14.66,
      date: DateTime.now()
    )
  ];

  void addNewTransactionPanel(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirBank Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => addNewTransactionPanel(context),
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blueAccent,
                child: Text('Chart'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addNewTransactionPanel(context),
      ),
    );
  }
}