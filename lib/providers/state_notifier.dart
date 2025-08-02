import 'package:flutter/material.dart';

class StateNotifier extends ChangeNotifier {
  bool _shouldRefresh = false;

  bool get shouldRefresh => _shouldRefresh;

  void triggerRefresh() {
    _shouldRefresh = true;
    notifyListeners();
  }

  void resetRefreshFlag() {
    _shouldRefresh = false;
  }
}
