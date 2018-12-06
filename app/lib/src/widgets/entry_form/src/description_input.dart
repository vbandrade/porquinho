import 'package:app/src/widgets/entry_form/src/styles.dart';
import 'package:flutter/material.dart';

class DescriptionInput extends StatefulWidget {
  @override
  DescriptionInputState createState() {
    return DescriptionInputState();
  }
}

class DescriptionInputState extends State<DescriptionInput> {
  final TextEditingController _controller = TextEditingController();

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
            keyboardType: TextInputType.text,
          ),
        ));
  }
}
