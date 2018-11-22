import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:money/money.dart';
import 'package:app/src/models/entry.dart';

class EntriesMixin {
  StreamTransformer<List<Entry>, Money> get amountTotalizerTransformer =>
      _amountTotalizerTransformer();

  StreamTransformer<List<Entry>, Money> _amountTotalizerTransformer() {
    return ScanStreamTransformer((Money acc, List<Entry> curr, int i) {
      return curr.fold<Money>(
          Money.fromDouble(0.0, Currency.fromCode("BRL")), _amountTotalizerCombiner);
    });
  }

  Money _amountTotalizerCombiner(Money previousValue, Entry element) {
    return previousValue + element.sumAmount;
  }
}
