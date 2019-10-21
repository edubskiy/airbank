import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:airbank/widgets/chart.dart';
import 'models/transaction.dart';
import 'package:airbank/widgets/new_transaction.dart';
import 'package:airbank/widgets/transaction_list.dart';

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

class _HomePageState extends State<HomePage> with  WidgetsBindingObserver {
  bool _isChartShown = false;

  @override
  void initState() {
    print("initState");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState");
    // // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);
  }
  
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

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

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show chart', style: Theme.of(context).textTheme.title),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _isChartShown,
            onChanged: _showChart,
          ),
        ],
      ),
      _isChartShown
        ? Container(
            height: (mediaQuery.size.height - 
              appBar.preferredSize.height - mediaQuery.padding.top) * 0.8,
            child: Chart(recentTransactions)
          )
        : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height - 
        appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
        child: Chart(recentTransactions)
      ),
      txListWidget
    ];
  }

  Widget _buildAppBarContent() {
    return Platform.isIOS 
      ? CupertinoNavigationBar(
          middle: Text('AirBank Home Page'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => addNewTransactionPanel(context),
              ),
            ],
          ),
        )
      : AppBar(
        title: Text('AirBank Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => addNewTransactionPanel(context),
          )
        ]
      );
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

    final PreferredSizeWidget appBar = _buildAppBarContent();

    final txListWidget = Container(
      height: (mediaQuery.size.height - 
        appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction)
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) 
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                txListWidget
              ),
            if ( ! isLandscape) 
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS 
    ? CupertinoPageScaffold(
        child: pageBody,
        navigationBar: appBar,
      )
    : Scaffold(
      appBar: appBar,
      body: pageBody,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS 
      ? Container() 
      : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addNewTransactionPanel(context),
      ),
    );
  }
}
