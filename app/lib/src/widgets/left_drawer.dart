import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
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
            title: Text("Pagina Inicial"),
            leading: Icon(Icons.inbox),
            onTap: () {},
          ),
          ListTile(
            title: Text("Transações"),
            leading: Icon(Icons.inbox),
            onTap: () {
              Navigator.pushNamed(context, "/entries")
            },
          ),
          ListTile(
            title: Text("Investimentos"),
            leading: Icon(Icons.calendar_today),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
