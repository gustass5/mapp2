import 'package:flutter/material.dart';
import './note_route_path.dart';
import './notes_state.dart';
import './app_shell.dart';

class NoteRouterDelegate extends RouterDelegate<NoteRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NoteRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  NotesState appState = NotesState();

  NoteRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  NoteRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return NotesSettingsPath();
    } else {
      if (appState.selectedNote == null) {
        return NotesListPath();
      } else {
        return NotesDetailsPath(appState.getSelectedBookById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('NotebookPage'),
          child: AppShell(appState: appState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedNote != null) {
          appState.selectedNote = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  // @override
  // GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();

  @override
  Future<void> setNewRoutePath(NoteRoutePath path) async {
    if (path is NotesListPath) {
      appState.selectedIndex = 0;
      appState.selectedNote = null;
    } else if (path is NotesSettingsPath) {
      appState.selectedIndex = 1;
    } else if (path is NotesDetailsPath) {
      appState.setSelectedBookById(path.id);
    }
  }
}
