import 'package:app/src/widgets/entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:app/src/models/entry.dart';

class EntryList extends StatelessWidget {
  final Stream<List<Entry>> _entriesList;

  const EntryList(this._entriesList);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _entriesList,
        builder: (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          List<Entry> _entriesList = snapshot.data ?? const [];
          return ListView.builder(
            itemCount: _entriesList.length,
            itemBuilder: (BuildContext context, int index) {
              return EntryTile(_entriesList[index]);
            },
          );
        });
  }
}
