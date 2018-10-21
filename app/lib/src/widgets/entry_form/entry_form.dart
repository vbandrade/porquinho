import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/amount_input.dart';
import 'package:app/src/widgets/entry_form/src/entry_type_picker.dart';
import 'package:app/src/widgets/entry_form/src/date_input.dart';
import 'package:app/src/widgets/entry_form/src/description_input.dart';
import 'package:app/src/widgets/entry_form/src/consolidated_input.dart';

class EntryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.description),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: DescriptionInput(),
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
                      child: ConsolidatedInput(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
