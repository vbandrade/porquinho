import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/entry_type.dart';

typedef OnEntryTap = void Function(Entry);

class EntryTile extends StatelessWidget {
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  final Entry entry;
  final OnEntryTap onEntryTap;

  EntryTile([
    this.entry,
    this.onEntryTap,
  ]);

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Container(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _colors[random.nextInt(2) % _colors.length],
          child: Text(entry.category.name[0]),
        ),
        title: Text(
          entry.description,
        ),
        subtitle: Wrap(spacing: 5.0, runSpacing: 3.0, children: <Widget>[
          Chip(
            label: Text(
              "${entry.account.name}",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Chip(
            label: Text(
              "${entry.category.name}",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ]),
        isThreeLine: true,
        trailing: Text(entry.amountString,
            style: TextStyle(
                color: entry.type == EntryType.credit
                    ? Colors.green
                    : Colors.black)),
        onTap: () {
          if (onEntryTap != null) onEntryTap(entry);
        },
      ),
    );
  }
}
