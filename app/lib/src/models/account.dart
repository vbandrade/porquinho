import 'package:meta/meta.dart';

enum AccountType {
  cash,
  checking,
  savings,
  investment,
}

class Account {
  final String id;
  final String name;
  final AccountType type;

  Account.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"] ?? "-",
        name = data["name"] ?? "sem nome",
        type = getType(data["type"]);

  @visibleForTesting
  static AccountType getType(String text) {
    AccountType result;

    try {
      result = text.contains("cash") ? AccountType.cash : AccountType.checking;
    } catch (error) {
      return AccountType.checking;
    }
    return result;
  }
}
