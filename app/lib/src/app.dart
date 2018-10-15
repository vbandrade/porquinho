import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:app/src/screens/routes.dart' as routes;

class App extends StatelessWidget {
  final router = Router();
  App() {
    routes.setup(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Porquinho",
      onGenerateRoute: router.generator,
    );
  }
}
