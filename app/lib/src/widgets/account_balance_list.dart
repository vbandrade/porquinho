import 'package:flutter/material.dart';
import 'package:app/src/blocs/home_bloc.dart';

class AccountBalanceList extends StatelessWidget {
  final List<AccountBalance> list;

  const AccountBalanceList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        AccountBalance ab = list[index];

        return ListTile(
          title: Text("${ab.acountName}"),
          leading: Icon(Icons.calendar_today),
          trailing: Text("${ab.amount}"),
          onTap: () {},
        );
      },
    );
  }
}
