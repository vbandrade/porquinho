class Category {
  final String name;

  Category(this.name);

  Category.fromMap(Map<String, dynamic> map)
      : name = map["name"] != null ? map["name"].toString() : "";
}
