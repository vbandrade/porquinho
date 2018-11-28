import 'package:app/src/models/month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
import 'package:app/src/widgets/entry_tile.dart';
import 'package:money/money.dart';

class EntryList extends StatelessWidget {
  final Stream<List<MonthlyGroupedEntries>> _entriesList;

  EntryList(this._entriesList);

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

                List<MonthlyGroupedEntries> _groupedList =
                    snapshot.data ?? const [];

                final widgetList =
                    List<Widget>.generate(_groupedList.length, (index) {
                  MonthlyGroupedEntries current = _groupedList[index];

                  return entriesListgenerator(current);
                });

                return CustomScrollView(slivers: widgetList);
              }),
        )
      ],
    );
  }

  Widget entriesListgenerator(MonthlyGroupedEntries current) {
    return SliverStickyHeaderBuilder(
      builder: (context, SliverStickyHeaderState state) =>
          MonthHeader(current.month, current.totalAmount, state),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => EntryTile(current.entries[index]),
          childCount: current.entries.length,
        ),
      ),
    );
  }
}

class MonthHeader extends StatelessWidget {
  final Month month;
  final Money totalAmount;
  final SliverStickyHeaderState state;

  const MonthHeader(this.month, this.totalAmount, this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: (state.isPinned ? Colors.pink : Colors.lightBlue)
          .withOpacity(1.0 - state.scrollPercentage),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "$month => $totalAmount",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
