import 'dart:async';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/serializers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ReactiveRepository {
  Stream<List<Entry>> getEntries();
}

class FirestoreRepository extends ReactiveRepository {
  final Firestore firestore;

  FirestoreRepository(this.firestore);

  static Future<FirestoreRepository> getInstance() async {
    Firestore _firestore = Firestore.instance;
    await _firestore.settings(
      timestampsInSnapshotsEnabled: true,
      persistenceEnabled: true,
      sslEnabled: true,
    );

    return FirestoreRepository(_firestore);
  }

  @override
  Stream<List<Entry>> getEntries() {
    return Firestore.instance
        .collection("entries")
        .where("date", isLessThanOrEqualTo: DateTime.now())
        .orderBy("date")
        .getDocuments()
        .then((snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        try {
          Entry result =
              serializers.deserializeWith<Entry>(Entry.serializer, doc.data);

          if (result.id == null)
            result = result.rebuild((b) => b..id = doc.documentID);

          return result;
        } catch (error) {
          print(error);
        }
      }).toList();
    }).asStream();
  }
}
