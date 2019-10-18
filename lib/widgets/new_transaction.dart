import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = selectedDate;
      });
    });
  }

  void _submitData() {
    if (_titleController.text.isEmpty) return;

    var title = _titleController.text;
    var amount = double.parse(_amountController.text);

    if (title.isEmpty || amount < 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen'
                          : "Chosen date:${DateFormat.yMMMd().format(_selectedDate)}"),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
