import 'package:airbank/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  // final List<Transaction> transactions = [
  //   Transaction(
  //     id: 't1',
  //     title: 'New shoes',
  //     amount: 69.99,
  //     date: DateTime.now()
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Weekly casual groceries',
  //     amount: 14.66,
  //     date: DateTime.now()
  //   )
  // ];

  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirBank Home Page'),
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
            UserTransactions()
          ],
        ),
      ),
    );
  }
}