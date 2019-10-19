import 'package:airbank/widgets/chart.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          button: TextStyle(color: Colors.white)
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isChartShown = false;

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
      title: title, 
      amount: amount, 
      date: selectedDate, 
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
    ),
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
    ),
    Transaction(
      id: 't3',
      title: 'New shoes',
      amount: 69.99,
      date: DateTime.now()
    ),
    Transaction(
      id: 't4',
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showChart(show) {
    setState(() {
      _isChartShown = show;
    });
  }

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('AirBank Home Page'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add), 
          onPressed: () => addNewTransactionPanel(context),
        )
      ]
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height - 
        appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction)
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show chart'),
                Switch.adaptive(
                  value: _isChartShown,
                  onChanged: _showChart,
                ),
              ],
            ),
            if ( ! isLandscape) Container(
              height: (mediaQuery.size.height - 
                appBar.preferredSize.height - mediaQuery.padding.top) * 0.4,
              child: Chart(recentTransactions)
            ),
            if ( ! isLandscape) txListWidget,
            if (isLandscape) _isChartShown
              ? Container(
                  height: (mediaQuery.size.height - 
                    appBar.preferredSize.height - mediaQuery.padding.top) * 0.8,
                  child: Chart(recentTransactions)
                )
              : txListWidget
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
