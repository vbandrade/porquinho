import 'package:app/src/screens/routes.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final Screens _currentScreen;
  SideDrawer(this._currentScreen);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Logged User"),
            accountEmail: Text("loggedUser@gmail.com"),
            currentAccountPicture: CircleAvatar(),
          ),
          ListTile(
            title: Text(
              "Contas",
              style: _currentScreen == Screens.expenses ? style : null,
            ),
            leading: Icon(Icons.inbox),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          ListTile(
            title: Text(
              "Investimentos",
              style: _currentScreen == Screens.investments ? style : null,
            ),
            leading: Icon(Icons.calendar_today),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
