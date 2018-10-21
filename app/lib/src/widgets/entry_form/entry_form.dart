import 'package:app/src/widgets/entry_form/src/date_input.dart';
import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/amount_input.dart';
import 'package:app/src/widgets/entry_form/src/entry_type_picker.dart';

class EntryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 18.0, color: Colors.purple[800]);

    const double topSpacing = 13.0;

    return Container(
        padding: EdgeInsets.only(top: 20.0, right: 10.0),
        child: Form(
          onChanged: () {},
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.attach_money),
                      onPressed: () {},
                    ),
                    Expanded(child: AmountInput()),
                    Expanded(
                      child: EntryTypePicker(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {},
                    ),
                    Expanded(child: DateInput()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.description),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextFormField(
                          style: style,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "descrição"),
                          autocorrect: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'por favor, insira uma transação';
                            }
                          },
                          onFieldSubmitted: (String value) {},
                          onSaved: (String value) {}),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.account_balance),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amberAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.category),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amberAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.label_outline),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amberAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topSpacing),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Consolidada",
                            style: style,
                          ),
                          IconButton(
                            icon: Icon(Icons.check_box_outline_blank),
                            onPressed: () {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
