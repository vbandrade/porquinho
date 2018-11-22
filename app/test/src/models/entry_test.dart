import 'package:flutter_test/flutter_test.dart';
import 'package:money/money.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/serializers.dart';
import "../helpers.dart";

void main() {
  group("Test Entry ", () {
    test("Amount string should ", () {
      final entry = EntriesHelper.getDebit(3.14);

      expect(entry.amountString, "-R\$ 3,14");
    });

    test('sum of debit entries should be negative', () {
      List<Entry> entries = [
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getDebit(3.14),
      ];
      final initialValue = Money.fromDouble(0.0, Currency.fromCode("BRL"));

      final result =
          entries.fold<Money>(initialValue, (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(-12.56, Currency.fromCode("BRL")));
    });

    test('sum of  entries according to type', () {
      List<Entry> entries = [
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getCredit(4.19),
      ];

      final result = entries
          .fold<Money>(Money.fromDouble(0.0, Currency.fromCode("BRL")),
              (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(1.05, Currency.fromCode("BRL")));
    });
    test('sum of entries of every to type', () {
      List<Entry> entries = [
        EntriesHelper.getDebit(3.14),
        EntriesHelper.getCredit(4.19),
        EntriesHelper.getTransferIn(2.22),
        EntriesHelper.getTransferOut(3.33),
      ];

      final result = entries
          .fold<Money>(Money.fromDouble(0.0, Currency.fromCode("BRL")),
              (previousValue, element) {
        return previousValue + element.sumAmount;
      });

      expect(result, Money.fromDouble(-0.06, Currency.fromCode("BRL")));
    });

    test('serializer shouldnt throw exception', () {
      final entry = EntriesHelper.getDebit(3.14);
      final serialized = serializers.serializeWith(Entry.serializer, entry);
      final entryDeserialized =
          serializers.deserializeWith(Entry.serializer, serialized);
      expect(entry, entryDeserialized);
    });
  });
}
