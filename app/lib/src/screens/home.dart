import 'package:app/src/blocs/provider.dart';
import 'package:flutter/material.dart';
import 'package:app/src/blocs/home_bloc.dart';
import 'package:app/src/widgets/left_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: null,
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: StreamBuilder<List<AccountBalance>>(
        stream: bloc.accountBalances,
        builder: (BuildContext context,
            AsyncSnapshot<List<AccountBalance>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                AccountBalance ab = snapshot.data[index];
                return ListTile(
                  title: Text("${ab.acountName}"),
                  leading: Icon(Icons.calendar_today),
                  trailing: Text("${ab.amount}"),
                  onTap: () {},
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
