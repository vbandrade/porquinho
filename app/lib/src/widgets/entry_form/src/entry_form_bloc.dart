import "dart:async";

class Bloc {
  Stream<bool> get submitValid => Stream.periodic(
        Duration(seconds: 1),
        (ocurrence) {
          return (ocurrence % 3 == 0);
        },
      );

  get submit => () {
        //do something
      };

  dispose() {}
}
