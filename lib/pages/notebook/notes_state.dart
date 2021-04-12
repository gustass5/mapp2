import 'package:flutter/material.dart';
import './note.dart';

class NotesState extends ChangeNotifier {
  int _selectedIndex;

  Note _selectedNote;

  List<Note> notes = [
    Note("Test", "Content", "2021-02-12"),
    Note("Test2", "Content2", "2021-02-13"),
    Note("Test3", "Content3", "2021-02-14"),
  ];

  NotesState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;
    if (_selectedIndex == 1) {
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

  int getSelectedBookById() {
    if (!notes.contains(_selectedNote)) return 0;
    return notes.indexOf(_selectedNote);
  }

  void setSelectedBookById(int id) {
    if (id < 0 || id > notes.length - 1) {
      return;
    }

    _selectedNote = notes[id];
    notifyListeners();
  }
}
