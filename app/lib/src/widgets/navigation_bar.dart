import 'package:app/src/blocs/monthly_expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBar extends StatefulWidget {
  final ReplaySubject<Month> _query;

  Sink<Month> get query => _query;

  NavigationBar({Sink<Month> query}) : _query = query ?? ReplaySubject<Month>();

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  DateFormat formater = DateFormat("MMM / yy");
  Month _currentMonth = Month(DateTime.now().month, DateTime.now().year);

  TextStyle currentMonthStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    Month previousMonth = _currentMonth.subtract(1);
    Month nextMonth = _currentMonth.add(1);

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
              child: Text("< $previousMonth"),
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  widget.query.add(previousMonth);
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
                  widget.query.add(nextMonth);
                  _currentMonth = nextMonth;
                });
              }),
        ],
      ),
    );
  }
}
