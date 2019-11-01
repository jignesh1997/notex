import 'package:flutter/foundation.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<String> _notes = null;

  List<String> get notes => _notes;

  set notes(List<String> value) {
    _notes = value;
    notifyListeners();
  }
}
