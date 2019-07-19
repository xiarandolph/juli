import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  BalancePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  TextEditingController _textController = TextEditingController();
  List<double> _expenses = <double>[];
  double _balance = 0.0;

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addExpense(double expense) {
    _expenses.add(expense);
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
                _addExpense(double.parse(_textController.text));
                Navigator.of(context).pop();
                // clear causes Android error: getTextBeforeCursor on inactive InputConnection
                // https://github.com/flutter/flutter/issues/9471
                //_textController.clear();
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
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(_expenses[index].toString());
                },
              ),
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
