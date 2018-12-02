import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';
import 'package:app/src/models/entry_type.dart';

class EntryTypePicker extends StatefulWidget {
  @override
  _EntryTypePickerState createState() => _EntryTypePickerState();
}

class _EntryTypePickerState extends State<EntryTypePicker> {
  EntryType selected = EntryType.debit;

  final entryTypes = [
    DropdownMenuItem<EntryType>(
      child: Text("Crédito"),
      value: EntryType.credit,
    ),
    DropdownMenuItem<EntryType>(
      child: Text("Debito"),
      value: EntryType.debit,
    ),
    DropdownMenuItem<EntryType>(
      child: Text("Transferência"),
      value: EntryType.transfer_in,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<EntryType>(
      style: Styles.userInputStyle,
      items: entryTypes,
      value: selected,
      onChanged: (EntryType value) {
        debugPrint(value.toString());
        setState(() {
          selected = value;
        });
      },
    );
  }
}
