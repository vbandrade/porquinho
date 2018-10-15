import 'package:app/src/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/widgets/entry_list.dart';

class MonthlyExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transações")),
      body: EntryList(
        Firestore.instance
            .collection('entries')
            .snapshots()
            .map((querySnapshot) {
          return querySnapshot.documents.map((documentSnapshot) {
            return Entry.fromMap(
                documentSnapshot.documentID, documentSnapshot.data);
          }).toList();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
          Navigator.of(context).pushNamed("/entry/new");
        },
      ),
    );
  }
}
