import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';

typedef OnChanged = void Function(DateTime);

class DateInput extends StatefulWidget {
  final OnChanged onChanged;

  const DateInput({this.onChanged});

  @override
  DateInputState createState() {
    return DateInputState();
  }
}

class DateInputState extends State<DateInput> {
  final dateFormatter = DateFormat('yyyy-MM-dd');

  DateTime selected;

  @override
  void initState() {
    super.initState();
    selected = _getFormatted(DateTime.now());
    if (widget.onChanged != null) widget.onChanged(selected);
  }

  DateTime _getFormatted(DateTime date) {
    return DateTime(date.year, date.month, date.day, 12);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[500]))),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              dateFormatter.format(selected),
              style: Styles.userInputStyle,
            ),
          ),
          onTap: () {
            this.selectDateFromPicker();
          },
        ));
  }

  Future<Null> selectDateFromPicker() async {
    DateTime result = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    setState(() {
      if (result != null) {
        selected = _getFormatted(result);
        if (widget.onChanged != null) widget.onChanged(selected);
      }
    });
  }
}
