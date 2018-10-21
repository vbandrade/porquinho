import 'package:flutter/material.dart';
import 'package:app/src/widgets/entry_form/src/entry_form_bloc.dart';
import 'package:app/src/widgets/entry_form/entry_form.dart';

class CreateEntryScreen extends StatelessWidget {
  final bloc = EntryFormBloc();

  Widget _submitButton() {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
          child: Text(
            'Salvar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: snapshot.hasData ? (snapshot.data ? () {} : null) : null,
          color: Colors.blue,
        );
      },
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
          child: _submitButton(),
        )
      ]),
    );
  }
}
