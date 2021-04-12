import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './notes_state.dart';
import './note_route_path.dart';
import './notebook_page.dart';
import './single_note_screen.dart';
import './note.dart';

class InnerRouterDelegate extends RouterDelegate<NoteRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NoteRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NotesState get appState => _appState;
  NotesState _appState;
  set appState(NotesState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  void _handleNoteTapped(Note note) {
    appState.selectedNote = note;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            key: ValueKey('NotebookPage'),
            child: NotebookPage(
              notes: appState.notes,
              onTapped: _handleNoteTapped,
            ),
          ),
          if (appState.selectedNote != null)
            MaterialPage(
              key: ValueKey(appState.selectedNote),
              child: SingleNoteScreen(note: appState.selectedNote),
            ),
        ] else
          FadeAnimationPage(
            // child: SettingsScreen(),
            key: ValueKey("SettingsPage"),
          ),
      ],
      onPopPage: (route, result) {
        appState.selectedNote = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NoteRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route ???
    assert(false);
  }
}

class FadeAnimationPage extends Page {
  final Widget child;

  FadeAnimationPage({Key key, this.child}) : super(key: key);

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        var curveTween = CurveTween(curve: Curves.easeIn);
        return FadeTransition(
          opacity: animation.drive(curveTween),
          child: child,
        );
      },
    );
  }
}
