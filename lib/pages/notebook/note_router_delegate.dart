import 'package:flutter/material.dart';
import 'package:mapp2/pages/notebook/single_note_page.dart';
import './note_route_path.dart';
import './note.dart';
import './notebook_page.dart';
import './single_note_page.dart';

class NoteRouterDelegate extends RouterDelegate<NoteRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NoteRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Note _selectedNote;
  bool show404 = false;

  List<Note> notes = [
    Note("Test", "Content", "2021-02-12"),
    Note("Test2", "Content2", "2021-02-13"),
    Note("Test3", "Content3", "2021-02-14"),
  ];

  NoteRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  void _handleNoteTapped(Note note) {
    _selectedNote = note;
    notifyListeners();
  }

  NoteRoutePath get currentConfiguration {
    if (show404) {
      return NoteRoutePath.unknown();
    }

    return _selectedNote == null
        ? NoteRoutePath.home()
        : NoteRoutePath.details(notes.indexOf(_selectedNote));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('NotebookPage'),
          child: NotebookPage(
            notes: notes,
            onTapped: _handleNoteTapped,
          ),
        ),
        if (show404)
          MaterialPage(
            key: ValueKey(
              'UnknownPage',
            ),
            // child: UnknownScreen(),
            child: Container(
              child: Text("Error 404"),
            ),
          )
        else if (_selectedNote != null)
          SingleNotePage(note: _selectedNote),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _selectedNote = null;
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  // @override
  // GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();

  @override
  Future<void> setNewRoutePath(NoteRoutePath path) async {
    if (path.isUnknown) {
      _selectedNote = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > notes.length - 1) {
        show404 = true;
        return;
      }

      _selectedNote = notes[path.id];
    } else {
      _selectedNote = null;
    }

    show404 = false;
  }
}
