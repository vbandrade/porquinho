import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/src/app.dart';

void main() async {
  Firestore firestore = Firestore.instance;
  await firestore.settings(
    timestampsInSnapshotsEnabled: true,
    persistenceEnabled: true,
    sslEnabled: true,
  );

  runApp(App());
}
