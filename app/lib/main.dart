import 'package:flutter/material.dart';
import 'package:app/src/app.dart';
import 'package:app/src/resources/injector.dart';

void main() async {
  injector = await configure();

  runApp(App());
}
