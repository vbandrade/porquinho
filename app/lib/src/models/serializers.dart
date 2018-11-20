import 'package:built_value/serializer.dart';
import "package:built_value/standard_json_plugin.dart";
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/entry_type.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';

part "serializers.g.dart";

@SerializersFor(const [Category, Account, AccountType, Entry, EntryType])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
