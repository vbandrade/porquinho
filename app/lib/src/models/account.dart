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
        type = data["type"].contains("cash")
            ? AccountType.cash
            : AccountType.checking;
}
