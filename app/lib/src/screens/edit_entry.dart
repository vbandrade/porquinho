import 'package:app/src/blocs/create_entry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app/src/blocs/edit_entry_bloc.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/widgets/entry_form/entry_form.dart';

class EditEntryScreen extends StatelessWidget {
  Widget _submitButton(EntryBloc bloc) {
    return StreamBuilder(
      stream: bloc.isValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
          child: Text(
            'Salvar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: bloc.save,
          color: Colors.blue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    EditEntryBloc bloc = Provider.of<EntryBloc>(context) as EditEntryBloc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar transação #${bloc.id}'),
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
          child: _submitButton(bloc),
        )
      ]),
    );
  }
}
