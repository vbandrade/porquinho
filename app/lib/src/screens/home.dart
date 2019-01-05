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
      List<IGrouping> dailyIterable = Collection(entries)
          .groupBy<String>((Entry x) => x.account.name)
          .toList();

      return dailyIterable.map((f) {
        return AccountBalance(
          f.key,
          Money.fromDouble(0, Currency.fromCode("BRL")),
        );
      }).toList();
    });
  }

  Stream<List<Entry>> _getEntries() {
    return Firestore.instance
        .collection("entries")
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
      body: Container(
        color: Colors.green,
        child: StreamBuilder<List<AccountBalance>>(
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
      ),
    );
  }
}
