import 'package:flutter/widgets.dart';

Type _typeOf<T>() => T;

class Provider<T> extends InheritedWidget {
  final T bloc;

  const Provider({Key key, this.bloc, Widget child})
      : super(key: key, child: child);

  static T of<T>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    final Provider<T> provider = context.inheritFromWidgetOfExactType(type);
    return provider?.bloc;
  }

  @override
  bool updateShouldNotify(Provider<T> oldWidget) {
    return true;
  }
}
