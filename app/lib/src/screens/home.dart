import 'package:app/src/models/entry_type.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queries/collections.dart';
import 'package:queries/queries.dart';
import 'package:money/money.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/serializers.dart';
import 'package:app/src/widgets/left_drawer.dart';

class AccountBalance {
  final String acountName;
  final Money amount;

  AccountBalance(this.acountName, this.amount);
}

class HomeBloc {
  Stream<List<AccountBalance>> get accountBalances => _getAccountBalances();

  Stream<List<AccountBalance>> _getAccountBalances() {
    return _getEntries().map<List<AccountBalance>>((List<Entry> entries) {
      List<IGrouping<String, Entry>> dailyIterable = Collection(entries)
          .groupBy<String>((Entry x) => x.account.name)
          .toList();

      return dailyIterable.map((f) {
        final entryList = f.toList();

        Money amount = entryList.fold<Money>(
            Money.fromDouble(0, Currency.fromCode("BRL")), combine);

        return AccountBalance(
          f.key,
          amount,
        );
      }).toList();
    });
  }

  Stream<List<Entry>> _getEntries() {
    return Firestore.instance
        .collection("entries")
        .where("date", isLessThanOrEqualTo: DateTime.now())
        .orderBy("date")
        .getDocuments()
        .then((snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        try {
          Entry result =
              serializers.deserializeWith<Entry>(Entry.serializer, doc.data);

          if (result.id == null)
            result = result.rebuild((b) => b..id = doc.documentID);

          return result;
        } catch (error) {
          print(error);
        }
      }).toList();
    }).asStream();
  }

  Money combine(Money previousValue, Entry entry) {
    if ((entry.type == EntryType.credit) ||
        (entry.type == EntryType.transfer_in))
      return previousValue + entry.amount;

    if ((entry.type == EntryType.debit) ||
        (entry.type == EntryType.transfer_out))
      return previousValue - entry.amount;

    return previousValue;
  }
}

class HomeScreen extends StatelessWidget {
  final HomeBloc bloc = HomeBloc();

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
