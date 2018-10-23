import 'package:app/src/models/account.dart';
import 'package:app/src/models/account_type.dart';
import 'package:app/src/models/category.dart';
import 'package:built_value/serializer.dart';
import "package:built_value/standard_json_plugin.dart";

part "serializers.g.dart";

@SerializersFor(const [
  Category,
  Account,
  AccountType,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
