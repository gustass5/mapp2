import 'package:flutter/material.dart';

class RouterState extends ChangeNotifier {
  int _navigationIndex;

  int _selectedNoteIndex;

  RouterState() : _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  set navigationIndex(int idx) {
    _navigationIndex = idx;
    if (_navigationIndex == 1) {
      // Remove this line if you want to keep the selected book when navigating
      // between "settings" and "home" which book was selected when Settings is
      // tapped.
      _selectedNoteIndex = null;
    }
    notifyListeners();
  }

  int get selectedNoteIndex => _selectedNoteIndex;

  set selectedNoteIndex(int index) {
    _selectedNoteIndex = index;
    notifyListeners();
  }
}
