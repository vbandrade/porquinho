import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/src/models/month.dart';

class NavigationBar extends StatefulWidget {
  final Function(Month) _onMonthChanged;

  NavigationBar(this._onMonthChanged);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final formater = DateFormat("MMM / yy");
  Month _currentMonth = Month.now();

  TextStyle currentMonthStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    final previousMonth = _currentMonth.subtract(1);
    final nextMonth = _currentMonth.add(1);

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
              child: Text("< $previousMonth"),
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  widget._onMonthChanged(previousMonth);

                  _currentMonth = previousMonth;
                });
              }),
          Expanded(
            child: FlatButton(
                child: Text(
                  _currentMonth.toString(),
                  style: currentMonthStyle,
                ),
                textColor: Colors.white,
                onPressed: () {
                  print("$_currentMonth");
                }),
          ),
          FlatButton(
              child: Text("$nextMonth >"),
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  widget._onMonthChanged(previousMonth);
                  _currentMonth = nextMonth;
                });
              }),
        ],
      ),
    );
  }
}
