import 'dart:async';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/entry_type.dart';
import 'package:app/src/resources/repository.dart';
import 'package:money/money.dart';
import 'package:queries/collections.dart';
import 'package:queries/queries.dart';

class AccountBalance {
  final String acountName;
  final Money amount;

  AccountBalance(this.acountName, this.amount);
}

class HomeBloc {
  final ReactiveRepository _repository;

  HomeBloc(this._repository);

  Stream<List<AccountBalance>> get accountBalances => _getAccountBalances();

  Stream<List<AccountBalance>> _getAccountBalances() {
    return _repository
        .getEntries()
        .map<List<AccountBalance>>((List<Entry> entries) {
      List<IGrouping<String, Entry>> dailyIterable = Collection(entries)
          .groupBy<String>((Entry x) => x.account.name)
          .toList();

      return dailyIterable.map((f) {
        final entryList = f.toList();

        Money amount = entryList.fold<Money>(
            Money.fromDouble(0, Currency.fromCode("BRL")), combine);

        return AccountBalance(
          f.key,
          amount,
        );
      }).toList();
    });
  }

  Money combine(Money previousValue, Entry entry) {
    if ((entry.type == EntryType.credit) ||
        (entry.type == EntryType.transfer_in))
      return previousValue + entry.amount;

    if ((entry.type == EntryType.debit) ||
        (entry.type == EntryType.transfer_out))
      return previousValue - entry.amount;

    return previousValue;
  }
}
