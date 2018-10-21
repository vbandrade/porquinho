import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/entry_form.dart';

class CreateEntryScreen extends StatelessWidget {
  submitButton() {
    return RaisedButton(
      child: Text(
        'Salvar',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: null,
      color: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar transação'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(children: [
        EntryForm(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: submitButton(),
        )
      ]),
    );
  }
}
