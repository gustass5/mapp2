import 'package:flutter/material.dart';
import './note.dart';

class NotebookState extends ChangeNotifier {
  List<Note> notes = [
    Note("Test", "Content", "2021-02-12"),
    Note("Test2", "Content2", "2021-02-13"),
    Note("Test3", "Content3", "2021-02-14"),
  ];

  int createNote() {
    notes.add(Note("NEW", "Content", "2021-02-12"));
    notifyListeners();

    return notes.length - 1;
  }

  Note updateNote(int index, headline, content, date) {
    Note note = Note(headline, content, date);
    notes[index] = note;
    notifyListeners();

    return note;
  }
}
