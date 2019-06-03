import 'package:app/src/screens/routes.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final Screens _currentScreen;
  SideDrawer(this._currentScreen);
  final TextStyle _selectedStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
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
              style: _currentScreen == Screens.expenses ? _selectedStyle : null,
            ),
            leading: Icon(Icons.inbox),
            onTap: _currentScreen != Screens.expenses
                ? () {
                    Navigator.pushReplacementNamed(context, "/");
                  }
                : null,
          ),
          FlatButton.icon(
            icon: Icon(Icons.list),
            label: Text(
              "Lista de transações",
              style: _currentScreen == Screens.expense_list
                  ? _selectedStyle
                  : null,
            ),
            onPressed: () {},
          ),
          ListTile(
            title: Text(
              "Investimentos",
              style:
                  _currentScreen == Screens.investments ? _selectedStyle : null,
            ),
            leading: Icon(Icons.calendar_today),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
