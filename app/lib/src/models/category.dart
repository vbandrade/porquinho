import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category.g.dart';

abstract class Category implements Built<Category, CategoryBuilder> {
  @nullable
  String get id;
  String get name;

  Category._();

  factory Category(String name) {
    return _$Category._(name: name);
  }

  factory Category.builder([updates(CategoryBuilder b)]) = _$Category;

  static Serializer<Category> get serializer => _$categorySerializer;
}
