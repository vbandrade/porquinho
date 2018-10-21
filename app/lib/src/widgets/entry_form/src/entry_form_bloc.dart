import "dart:async";

class EntryFormBloc {
  Stream<bool> _valid = Stream.periodic(
    Duration(seconds: 1),
    (ocurrence) {
      return (ocurrence % 3 == 0);
    },
  );

  Stream<bool> get submitValid => _valid;

  get submit => () {
        //do something
      };

  dispose() {}
}
