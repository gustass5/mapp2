import 'package:flutter/material.dart';

class RouterState extends ChangeNotifier {
  int _navigationIndex;

  int _selectedNoteIndex;

  String _selectedRepository;

  RouterState() : _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  set navigationIndex(int idx) {
    _navigationIndex = idx;
    if (_navigationIndex == 1) {
      _selectedNoteIndex = null;
      _selectedRepository = null;
    }
    notifyListeners();
  }

  int get selectedNoteIndex => _selectedNoteIndex;

  set selectedNoteIndex(int index) {
    _selectedNoteIndex = index;
    notifyListeners();
  }

  String get selectedRepository => _selectedRepository;

  set selectedRepository(String name) {
    _selectedRepository = name;
    notifyListeners();
  }
}
