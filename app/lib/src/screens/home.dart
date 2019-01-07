import 'package:app/src/blocs/provider.dart';
import 'package:app/src/widgets/account_balance_list.dart';
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
            return AccountBalanceList(snapshot.data);
          }

          return Container();
        },
      ),
    );
  }
}
