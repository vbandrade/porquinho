import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/serializers.dart';
import 'package:app/src/blocs/create_entry_bloc.dart';

class EditEntryBloc extends CreateEntryBloc with AmountValidator {
  final String id;

  Future<Entry> get futureEntry => _getEntry(id);

  EditEntryBloc(this.id) {
    futureEntry.then((_entry) {
      onAmountChanged(_entry.amount);
      onDateChanged(_entry.date);
      onTypeChanged(_entry.type);
      onDescriptionChanged(_entry.description);
    });
  }

  Future<Entry> _getEntry(String id) {
    return Firestore.instance.document("entries/$id").get().then((snapshot) {
      Entry result =
          serializers.deserializeWith<Entry>(Entry.serializer, snapshot.data);

      if (result.id == null)
        result = result.rebuild((b) => b..id = snapshot.documentID);

      return result;
    });
  }
}
