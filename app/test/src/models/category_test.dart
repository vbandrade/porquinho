import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/serializers.dart';

import 'package:app/src/models/category.dart';

void main() {
  group("Test Category model", () {
    test("category created from map", () {
      final map = {
        "name": "Sports",
      };
      final result = serializers.deserializeWith(Category.serializer, map);
      expect(result.name, "Sports");
    });
    test("category created from map with null value", () {
      final map = {
        "name": null,
      };
      final result = serializers.deserializeWith(Category.serializer, map);
      expect(result.name, "");
    });
  });
}
