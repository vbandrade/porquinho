import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money/money.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';

class AmountInput extends StatefulWidget {
  final Currency currency;
  final NumberFormat formatter;

  AmountInput({String currencyName = "BRL"})
      : currency = Currency.fromCode(currencyName),
        formatter = NumberFormat.currency(
          locale: "pt_BR",
          symbol: 'R\$ ',
          name: currencyName,
        );

  @override
  _AmountInputState createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  final TextEditingController _controller = TextEditingController();

  _AmountInputState() {
    _controller.addListener(_pinCursorToEnd);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.formatter.format(0);
  }

  void _pinCursorToEnd() {
    if (_controller.selection.baseOffset != _controller.text.length) {
      _controller.selection = _controller.selection.copyWith(
        baseOffset: _controller.text.length,
        extentOffset: _controller.text.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[500]))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: TextField(
            style: Styles.userInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            controller: _controller,
            onChanged: (val) {
              debugPrint(val);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(19),
              MoneyFormatter(widget.formatter, widget.currency),
            ],
            keyboardType: TextInputType.number,
          ),
        ));
  }
}

class MoneyFormatter implements TextInputFormatter {
  NumberFormat formatter;
  final Currency currency;

  MoneyFormatter(this.formatter, this.currency);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldText, TextEditingValue newText) {
    final BigInt rawAmount = _stringToAmount(newText.text);
    final String formattedAmount = _amountToString(rawAmount);

    return newText.copyWith(text: formattedAmount);
  }

  BigInt _stringToAmount(String text) =>
      BigInt.tryParse(text.replaceAll(RegExp(r'[^\d]'), '')) ?? BigInt.from(0);

  String _amountToString(BigInt amount) =>
      formatter.format(amount / BigInt.from(currency.subUnit)).trim();
}
