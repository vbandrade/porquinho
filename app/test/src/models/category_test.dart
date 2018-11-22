import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/serializers.dart';

import 'package:app/src/models/category.dart';

void main() {
  group("Test Category model", () {
    test('serializer shouldnt throw exception', () {
      final category = Category("name");
      final serialized =
          serializers.serializeWith(Category.serializer, category);
      final categoryDeserialized =
          serializers.deserializeWith(Category.serializer, serialized);
      expect(category, categoryDeserialized);
    });
  });
}
