import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:app/src/blocs/monthly_expenses_bloc.dart';
import 'package:app/src/widgets/entry_tile.dart';

class EntryList extends StatelessWidget {
  final Stream<List<MonthlyGroupedEntries>> _entriesList;

  EntryList(this._entriesList);

  @override
  Widget build(BuildContext context) {
    return _buildGroupedByMonth(context);
  }

  Widget _buildGroupedByMonth(BuildContext context) {
    return StreamBuilder(
        stream: _entriesList,
        builder: (BuildContext context,
            AsyncSnapshot<List<MonthlyGroupedEntries>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error),
            );

          List<MonthlyGroupedEntries> _groupedList = snapshot.data ?? const [];

          final widgetList =
              List<Widget>.generate(_groupedList.length, (index) {
            MonthlyGroupedEntries current = _groupedList[index];

            return entriesListgenerator(current);
          });

          return CustomScrollView(slivers: widgetList);
        });
  }

  entriesListgenerator(MonthlyGroupedEntries current) {
    return SliverStickyHeaderBuilder(
      builder: (context, state) => Container(
            height: 60.0,
            color: (state.isPinned ? Colors.pink : Colors.lightBlue)
                .withOpacity(1.0 - state.scrollPercentage),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              current.month.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => EntryTile(current.entries[index]),
          childCount: current.entries.length,
        ),
      ),
    );
  }
}
