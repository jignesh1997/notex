import 'package:flutter/foundation.dart';

class AddNotesScreenProvider extends ChangeNotifier {
  String _noteText;

  String get noteText => _noteText;

  set noteText(String value) {
    _noteText = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _noteText = null;
    super.dispose();
  }
}
