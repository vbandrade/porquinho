import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/serializers.dart';

void main() {
  group("Test Account model", () {
    test('serializer shouldnt throw exception', () {
      final builder = AccountBuilder()
        ..name = "category"
        ..type = AccountType.cash;
      final account = builder.build();
      final serialized = serializers.serializeWith(Account.serializer, account);
      final accountDeserialized =
          serializers.deserializeWith(Account.serializer, serialized);
      expect(account, accountDeserialized);
    });
  });
}
