import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/entry_type.dart';

void main() {
  group("Test Entry Type", () {
    test("There are 4 EntryTypes: credit, debit, transfer_in, transfer_out",
        () {
      expect(EntryType.values.length, 4);
    });
  });
}
