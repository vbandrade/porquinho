import 'package:flutter_test/flutter_test.dart';

import 'package:app/src/models/entry.dart';

void main() {
  group("Test Entry ammountString", () {
    Map<String, dynamic> _getEntryMap() {
      Map<String, dynamic> categoryMap = Map<String, dynamic>();
      categoryMap["name"] = "Sports";

      Map<String, dynamic> account = Map<String, dynamic>();
      account["name"] = "cashhh";
      account["type"] = "EntryAccountType.cash";

      return {
        "type": EntryType.debit.toString(),
        "amount": 3.14,
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
  });
}
