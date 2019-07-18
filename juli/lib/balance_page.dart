import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  BalancePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  TextEditingController _textController = TextEditingController();
  double _balance = 0.0;

  void _addExpense() {
    double expense = 0;
    setState(() {
      _balance += expense;
    });
  }

  _displayExpenseDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add expense'),
          content: TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Add'),
              onPressed: () {
                setState(() {
                  _balance += double.parse(_textController.text);
                });
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your current balance is:',
            ),
            Text(
              '$_balance',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayExpenseDialog(context),
        tooltip: 'Add expense',
        child: Icon(Icons.add),
      ),
    );
  }
}
