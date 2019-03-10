import 'dart:async';
import 'package:app/src/resources/repository.dart';
import 'package:injector/injector.dart';

Injector injector;

Future<Injector> configure() async {
  Injector injector = Injector();

  ReactiveRepository repo = await FirestoreRepository.getInstance();
  injector.registerDependency<ReactiveRepository>((_) => repo);

  return injector;
}
