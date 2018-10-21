import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';

class ConsolidatedInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Consolidada",
          style: Styles.userInputStyle,
        ),
        IconButton(
          icon: Icon(Icons.check_box_outline_blank),
          onPressed: () {},
        )
      ],
    );
  }
}
