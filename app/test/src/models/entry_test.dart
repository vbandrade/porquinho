import 'package:flutter_test/flutter_test.dart';

import 'package:app/src/models/entry.dart';
import 'package:money/money.dart';

void main() {
  group("Test Entry ", () {
    Map<String, dynamic> _getEntryMap({
      double amount = 3.14,
      EntryType type = EntryType.debit,
    }) {
      Map<String, dynamic> categoryMap = Map<String, dynamic>();
      categoryMap["name"] = "Sports";

      Map<String, dynamic> account = Map<String, dynamic>();
      account["name"] = "cashhh";
      account["type"] = "EntryAccountType.cash";

      return {
        "type": type.toString(),
        "amount": amount,
        "date": DateTime.now(),
        "category": categoryMap,
        "description": "lallalalalla",
        "account": account
      };
    }

    test("Amount string should ", () {
      final entryMap = _getEntryMap();
      final entry = Entry.fromMap("id1234", entryMap);

      expect(entry.amountString, "-R\$ 3,14");
    });

    test('sum of debit entries should be negative', () {
      final entryMap = _getEntryMap();
      List<Entry> entries = [
        Entry.fromMap("id1234", entryMap),
        Entry.fromMap("id1234", entryMap),
        Entry.fromMap("id1234", entryMap),
        Entry.fromMap("id1234", entryMap),
      ];
      var initialValue = Money.fromDouble(0.0, Currency("BRL"));

      final result =
          entries.fold<Money>(initialValue, (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(-12.56, Currency("BRL")));
    });

    Entry _getDebit(double value) {
      return Entry.fromMap("id1234", _getEntryMap(amount: value));
    }

    Entry _getCredit(double value) {
      return Entry.fromMap(
          "id1234", _getEntryMap(amount: value, type: EntryType.credit));
    }

    Entry _getTransferIn(double value) {
      return Entry.fromMap(
          "id1234", _getEntryMap(amount: value, type: EntryType.transfer_in));
    }

    Entry _getTransferOut(double value) {
      return Entry.fromMap(
          "id1234", _getEntryMap(amount: value, type: EntryType.transfer_out));
    }

    test('sum of  entries according to type', () {
      List<Entry> entries = [
        _getDebit(3.14),
        _getCredit(4.19),
      ];

      final result = entries.fold<Money>(Money.fromDouble(0.0, Currency("BRL")),
          (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(1.05, Currency("BRL")));
    });
    test('sum of entries of every to type', () {
      List<Entry> entries = [
        _getDebit(3.14),
        _getCredit(4.19),
        _getTransferIn(2.22),
        _getTransferOut(3.33),
      ];

      final result = entries.fold<Money>(Money.fromDouble(0.0, Currency("BRL")),
          (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(-0.06, Currency("BRL")));
    });
  });
}
