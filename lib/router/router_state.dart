import 'package:flutter/material.dart';
import '../pages/notebook/note.dart';

class RouterState extends ChangeNotifier {
  int _navigationIndex;

  Note _selectedNote;

  List<Note> notes = [
    Note("Test", "Content", "2021-02-12"),
    Note("Test2", "Content2", "2021-02-13"),
    Note("Test3", "Content3", "2021-02-14"),
  ];

  RouterState() : _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  set navigationIndex(int idx) {
    _navigationIndex = idx;
    if (_navigationIndex == 1) {
      // Remove this line if you want to keep the selected book when navigating
      // between "settings" and "home" which book was selected when Settings is
      // tapped.
      _selectedNote = null;
    }
    notifyListeners();
  }

  Note get selectedNote => _selectedNote;

  set selectedNote(Note book) {
    _selectedNote = book;
    notifyListeners();
  }

  int getSelectedNoteById() {
    if (!notes.contains(_selectedNote)) return 0;
    return notes.indexOf(_selectedNote);
  }

  void setSelectedNoteById(int id) {
    if (id < 0 || id > notes.length - 1) {
      return;
    }

    _selectedNote = notes[id];
    notifyListeners();
  }
}
