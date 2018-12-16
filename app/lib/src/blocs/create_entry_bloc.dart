import 'dart:async';
import 'dart:math';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/serializers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:money/money.dart';
import 'package:app/src/models/entry_type.dart';

class CreateEntryBloc with AmountValidator implements EntryBloc {
  final BehaviorSubject<Money> _amountController = BehaviorSubject<Money>();
  final BehaviorSubject<DateTime> _dateController = BehaviorSubject<DateTime>();
  final BehaviorSubject<EntryType> _typeController =
      BehaviorSubject<EntryType>();
  final BehaviorSubject<String> _descriptionController =
      BehaviorSubject<String>();

  Function(Money) get onAmountChanged => _amountController.sink.add;
  Function(DateTime) get onDateChanged => _dateController.sink.add;
  Function(EntryType) get onTypeChanged => _typeController.sink.add;
  Function(String) get onDescriptionChanged => _descriptionController.sink.add;

  Stream<Money> get amount =>
      _amountController.stream.transform(validateAmount);
  Stream<DateTime> get date => _dateController.stream;
  Stream<EntryType> get type => _typeController.stream;
  Stream<String> get description => _descriptionController.stream;

  Stream<bool> get isValid => Observable.combineLatest4(
      amount, date, type, description, (a, d, t, de) => true);

  onDispose() {
    _amountController.close();
    _dateController.close();
    _typeController.close();
    _descriptionController.close();
  }

  DateTime _date;

  CreateEntryBloc() {
    _dateController.listen((DateTime onData) {
      print(onData.toString());
      _date = onData.toUtc();
    });
  }

  @override
  void save() {
    print("CreateEntryBloc.save");
    print("date: ${_date}");

    Random r = new Random();

    List<String> categories = [
      "farmacia",
      "random",
      "mergulho",
      "academia",
      "taxi"
    ];

    final catBuilder = CategoryBuilder()
      ..name = categories[r.nextInt(categories.length)];
    final accBuilder = AccountBuilder()
      ..type = AccountType.cash
      ..name = "cha ching!";

    final amountBuilder = Money.fromDouble(
      r.nextDouble() * 100,
      Currency.fromCode("BRL"),
    ).toBuilder();

    final builder = EntryBuilder()
      ..description = "from built_value \\o/"
      ..amount = amountBuilder
      ..date = _date
      ..type = r.nextBool() ? EntryType.credit : EntryType.debit
      ..category = catBuilder
      ..account = accBuilder;

    Firestore.instance.runTransaction((Transaction transactionHandler) async {
      CollectionReference reference = Firestore.instance.collection("entries");

      await reference
          .add(serializers.serializeWith(Entry.serializer, builder.build()));
    });
  }
}

class AmountValidator {
  final StreamTransformer<Money, Money> validateAmount =
      StreamTransformer.fromHandlers(handleData: (amount, sink) {
    if (amount.amount == 0) {
      sink.addError("Valor deve ser maior que zero.");
    } else {
      sink.add(amount);
    }
  });
}

abstract class EntryBloc {
  Function(Money) get onAmountChanged;
  Function(DateTime) get onDateChanged;
  Function(EntryType) get onTypeChanged;
  Function(String) get onDescriptionChanged;

  Stream<Money> get amount;
  Stream<DateTime> get date;
  Stream<EntryType> get type;
  Stream<String> get description;

  Stream<bool> get isValid;

  void save();
}
