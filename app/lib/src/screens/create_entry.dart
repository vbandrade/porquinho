import 'package:flutter/material.dart';

class CreateEntryScreen extends StatelessWidget {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: RaisedButton(
            child: Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
            color: Colors.blue,
          ),
        )
      ]),
    );
  }
}
