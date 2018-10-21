import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/widgets/entry_form/src/entry_form_bloc.dart';

void main() {
  group("Test EntryFormBloc", () {
    ///TODO: Use WidgetTester
    test("Test submitValid is switching in intervals of 3 ocurrences", () {
      EntryFormBloc bloc = EntryFormBloc();

      int counter = 0;

      bloc.submitValid.listen(expectAsync1((value) {
        expect(value, (counter % 3 == 0));
        counter++;
      }, count: 7));
    });
  });
}
