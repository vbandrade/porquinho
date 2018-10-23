import 'package:flutter_test/flutter_test.dart';
import 'package:money/money.dart';
import 'package:app/src/models/entry.dart';
import "../helpers.dart";

void main() {
  group("Test Entry ", () {
    test("Amount string should ", () {
      final entryMap = EntriesHelper.getEntryMap();
      final entry = Entry.fromMap("id1234", entryMap);

      expect(entry.amountString, "-R\$ 3,14");
    });

    test('sum of debit entries should be negative', () {
      final entryMap = EntriesHelper.getEntryMap();
      List<Entry> entries = [
        Entry.fromMap("id1234", entryMap),
        Entry.fromMap("id1234", entryMap),
        Entry.fromMap("id1234", entryMap),
        Entry.fromMap("id1234", entryMap),
      ];
      final initialValue = Money.fromDouble(0.0, Currency("BRL"));

      final result =
          entries.fold<Money>(initialValue, (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(-12.56, Currency("BRL")));
    });

    test('sum of  entries according to type', () {
      List<Entry> entries = [
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getCredit(4.19),
      ];

      final result = entries.fold<Money>(Money.fromDouble(0.0, Currency("BRL")),
          (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(1.05, Currency("BRL")));
    });
    test('sum of entries of every to type', () {
      List<Entry> entries = [
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getCredit(4.19),
        EntriesHelper.getTransferIn(2.22),
        EntriesHelper.getTransferOut(3.33),
      ];

      final result = entries.fold<Money>(Money.fromDouble(0.0, Currency("BRL")),
          (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(-0.06, Currency("BRL")));
    });
  });
}
