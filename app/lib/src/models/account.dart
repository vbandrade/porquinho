import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'account.g.dart';

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

abstract class Account implements Built<Account, AccountBuilder> {
  @nullable
  String get id;
  String get name;
  AccountType get type;

  Account._();
  factory Account([updates(AccountBuilder b)]) = _$Account;

  static Serializer<Account> get serializer => _$accountSerializer;
}
