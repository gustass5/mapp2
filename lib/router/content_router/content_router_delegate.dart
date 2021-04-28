import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../router_state.dart';
import '../route_path.dart';
import '../../pages/notebook/notebook_page.dart';
import '../../pages/notebook/notebook_note_page.dart';
import '../../pages/notebook/notebook_state.dart';

class ContentRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RouterState get routerState => _routerState;
  RouterState _routerState;
  set routerState(RouterState value) {
    if (value == _routerState) {
      return;
    }
    _routerState = value;
    notifyListeners();
  }

  ContentRouterDelegate(this._routerState);

  void _handleNoteTapped(int index) {
    routerState.selectedNoteIndex = index;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    var notebookState = context.watch<NotebookState>();
    return Navigator(
      key: navigatorKey,
      pages: [
        if (routerState.navigationIndex == 0)
          FadeAnimationPage(
            // child: Home(),
            key: ValueKey("HomePage"),
          )
        else if (routerState.navigationIndex == 1) ...[
          FadeAnimationPage(
            key: ValueKey('NotebookPage'),
            child: NotebookPage(
              routerState: routerState,
              notes: notebookState.notes,
              onTapped: _handleNoteTapped,
            ),
          ),
          if (routerState.selectedNoteIndex != null)
            MaterialPage(
              key: ValueKey(routerState.selectedNoteIndex),
              child: NotebookNotePage(noteIndex: routerState.selectedNoteIndex),
            ),
        ] else
          FadeAnimationPage(
            // child: SettingsScreen(),
            key: ValueKey("SettingsPage"),
          ),
      ],
      onPopPage: (route, result) {
        routerState.selectedNoteIndex = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
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
