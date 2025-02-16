import 'package:flutter/foundation.dart';

class ListValuesNotifier implements ValueListenable<dynamic> {
  final List<ValueListenable> valueListeners;
  late final Listenable listenable;
  bool val = false;

  ListValuesNotifier(this.valueListeners) {
    listenable = Listenable.merge(valueListeners);
    listenable.addListener(onNotified);
  }

  @override
  void addListener(VoidCallback listener) {
    listenable.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listenable.removeListener(listener);
  }

  @override
  bool get value => val;

  void onNotified() {
    val = !val;
  }
}