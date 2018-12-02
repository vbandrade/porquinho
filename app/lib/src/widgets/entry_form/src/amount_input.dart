import 'dart:math';

import 'package:app/src/widgets/entry_form/src/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmountInput extends StatefulWidget {
  @override
  _AmountInputState createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  final numberFormatter = NumberFormat.simpleCurrency(
      decimalDigits: 2, locale: "pt_BR", name: "BRL");

  double amount = Random().nextDouble() * 1000;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[500]))),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              numberFormatter.format(amount),
              style: Styles.userInputStyle,
            ),
          ),
          onTap: () {},
        ));
  }
}
