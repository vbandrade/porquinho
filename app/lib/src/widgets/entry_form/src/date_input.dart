import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';

class DateInput extends StatelessWidget {
  final dateFormatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[500]))),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              dateFormatter.format(DateTime.now()),
              style: Styles.userInputStyle,
            ),
          ),
          onTap: () {},
        ));
  }
}
