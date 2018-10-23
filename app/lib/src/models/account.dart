import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part "account.g.dart";

class AccountType extends EnumClass {
  static Serializer<AccountType> get serializer => _$accountTypeSerializer;
  static const AccountType cash = _$cash;
  static const AccountType checking = _$checking;
  static const AccountType savings = _$savings;
  static const AccountType investment = _$investment;

  const AccountType._(String name) : super(name);

  static BuiltSet<AccountType> get values => _$stValues;
  static AccountType valueOf(String name) => _$stValueOf(name);
}

class Account {
  final String id;
  final String name;
  final AccountType type;

  Account.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"] ?? "-",
        name = data["name"] ?? "sem nome",
        type = AccountType.valueOf(
            data["type"] ?? AccountType.checking.toString());
}
