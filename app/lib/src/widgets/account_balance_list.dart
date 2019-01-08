import 'package:flutter/material.dart';
import 'package:money/money.dart';
import 'package:app/src/blocs/home_bloc.dart';

class AccountBalanceList extends StatelessWidget {
  final List<AccountBalance> list;
  final Money totalBalance;

  AccountBalanceList(this.list)
      : totalBalance = list.fold<Money>(
            Money.fromDouble(0.0, Currency.fromCode("BRL")),
            (Money previousValue, AccountBalance element) =>
                previousValue + element.amount);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "$totalBalance",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "saldo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
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
          ),
        ),
      ],
    );
  }
}
