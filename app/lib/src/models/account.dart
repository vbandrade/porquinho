import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:app/src/models/account_type.dart';

part 'account.g.dart';

abstract class Account implements Built<Account, AccountBuilder> {
  //TODO: RETIRAR NULLABLE
  @nullable
  String get id;
  String get name;
  AccountType get type;

  Account._();
  factory Account([updates(AccountBuilder b)]) = _$Account;

  static Serializer<Account> get serializer => _$accountSerializer;
}
