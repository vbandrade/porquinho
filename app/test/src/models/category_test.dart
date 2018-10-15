import 'package:flutter_test/flutter_test.dart';

import 'package:app/src/models/category.dart';

void main() {
  group("Test Category model", () {
    test("category created from map", () {
      var map = {
        "name": "Sports",
      };
      var result = Category.fromMap(map);
      expect(result.name, "Sports");

      result = Category.fromMap(map);
      expect(result.name, "Sports");
    });
    test("category created from map with null value", () {
      var map = {
        "name": null,
      };
      var result = Category.fromMap(map);
      expect(result.name, "");
    });
  });
}
