import 'package:flutter_test/flutter_test.dart';

import 'package:app/src/models/account.dart';

void main() {
  group("Test Account model", () {
    test("account created from map", () {
      final map = {
        "id": "123",
        "name": "cash",
        "type": "cash",
      };
      final result = Account.fromMap(map);

      expect(result.type, AccountType.cash);
    });
  });
}
