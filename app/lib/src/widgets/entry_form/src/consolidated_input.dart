import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/styles.dart';

class ConsolidatedInput extends StatefulWidget {
  @override
  ConsolidatedInputState createState() {
    return ConsolidatedInputState();
  }
}

class ConsolidatedInputState extends State<ConsolidatedInput> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Consolidada",
          style: Styles.userInputStyle,
        ),
        IconButton(
          icon: Icon(getIcon()),
          onPressed: () {
            setState(() {
              selected = !selected;
            });
          },
        )
      ],
    );
  }

  IconData getIcon() {
    if (selected) return Icons.check_box;
    return Icons.check_box_outline_blank;
  }
}
