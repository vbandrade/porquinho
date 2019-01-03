import 'package:app/src/widgets/left_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.fiber_new),
            color: Colors.white,
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            color: Colors.white,
            onPressed: null,
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
