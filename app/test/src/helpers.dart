import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}
