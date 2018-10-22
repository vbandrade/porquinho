import 'package:app/src/models/entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/blocs/entries_mixin.dart';
import 'package:money/money.dart';
import 'package:rxdart/rxdart.dart';

import '../helpers.dart';

void main() {
  group("Test EntriesMixin", () {
    test('rx.Observable.scan.reusable', () async {
      final mix = EntriesMixin();

      List<Entry> entries = [
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getCredit(4.19),
        EntriesHelper.getTransferIn(2.22),
        EntriesHelper.getTransferOut(3.33),
      ];

      Observable(Stream.fromIterable([entries]))
          .transform(mix.amountTotalizerTransformer)
          .listen(expectAsync1((result) {
            expect(result, Money.fromDouble(-0.06, Currency("BRL")));
          }, count: 1));
    });
  });
}
