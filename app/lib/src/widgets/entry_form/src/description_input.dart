import 'package:app/src/widgets/entry_form/src/styles.dart';
import 'package:flutter/material.dart';

class DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: Styles.userInputStyle,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: "descrição"),
        autocorrect: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'por favor, insira uma transação';
          }
        },
        onFieldSubmitted: (String value) {},
        onSaved: (String value) {});
  }
}
