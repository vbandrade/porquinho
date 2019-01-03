import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:money/money.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
import 'package:app/src/widgets/entry_tile.dart';

class EntryList extends StatelessWidget {
  final Stream<List<GroupedEntries>> entriesListStream;
  final OnEntryTap onEntryTap;

  EntryList({this.entriesListStream, this.onEntryTap});

  @override
  Widget build(BuildContext context) {
    return _buildGroupedByMonth(context);
  }

  Widget _buildGroupedByMonth(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: StreamBuilder(
              stream: entriesListStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<GroupedEntries>> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (snapshot.hasError)
                  return Center(
                    child: Text(snapshot.error),
                  );

                List<GroupedEntries> _groupedList =
                    snapshot.data ?? const [];

                final widgetList =
                    List<Widget>.generate(_groupedList.length, (index) {
                  GroupedEntries current = _groupedList[index];

                  return entriesListgenerator(current);
                });

                return CustomScrollView(slivers: widgetList);
              }),
        )
      ],
    );
  }

  Widget entriesListgenerator(GroupedEntries current) {
    return SliverStickyHeaderBuilder(
      builder: (context, SliverStickyHeaderState state) =>
          GroupHeader(current.key.toString(), current.totalAmount, state),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => EntryTile(current.entries[index], onEntryTap),
          childCount: current.entries.length,
        ),
      ),
    );
  }
}

class GroupHeader extends StatelessWidget {
  final String title;
  final Money totalAmount;
  final SliverStickyHeaderState state;

  const GroupHeader(this.title, this.totalAmount, this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: (state.isPinned ? Colors.pink : Colors.lightBlue)
          .withOpacity(1.0 - state.scrollPercentage),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "$title => $totalAmount",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
