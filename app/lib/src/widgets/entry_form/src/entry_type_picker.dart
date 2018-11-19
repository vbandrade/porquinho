import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';
import 'package:app/src/models/entry_type.dart';

class EntryTypePicker extends StatefulWidget {
  @override
  _EntryTypePickerState createState() => _EntryTypePickerState();
}

class _EntryTypePickerState extends State<EntryTypePicker> {
  List<DropdownMenuItem<String>> entryType = [
    DropdownMenuItem<String>(
      child: Text("Crédito"),
      value: EntryType.credit.toString(),
    ),
    DropdownMenuItem<String>(
      child: Text("Debito"),
      value: EntryType.debit.toString(),
    ),
    DropdownMenuItem<String>(
      child: Text("Transferência"),
      value: EntryType.transfer_in.toString(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: Styles.userInputStyle,
      items: entryType,
      onChanged: (String value) {},
    );
  }
}
