import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:meta/meta.dart';

part 'category.g.dart';

abstract class Category implements Built<Category, CategoryBuilder> {
  String get name;

  Category._();
  factory Category([updates(CategoryBuilder b)]) = _$Category;

  static Serializer<Category> get serializer => _$categorySerializer;
}

abstract class CategoryBuilder implements Builder<Category, CategoryBuilder> {
  @virtual
  String name = "";

  factory CategoryBuilder() = _$CategoryBuilder;
  CategoryBuilder._();
}
