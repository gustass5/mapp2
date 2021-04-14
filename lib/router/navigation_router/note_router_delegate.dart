import 'package:flutter/material.dart';
import '../route_path.dart';
import '../router_state.dart';
import '../../pages/app/app_shell.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  RouterState routerState = RouterState();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    routerState.addListener(notifyListeners);
  }

  RoutePath get currentConfiguration {
    if (routerState.navigationIndex == 0) {
      return HomePath();
    } else if (routerState.navigationIndex == 2) {
      return SettingsPath();
    } else {
      // Handle Notebook notes
      if (routerState.selectedNote == null) {
        return NotebookPath();
      } else {
        return NotebookNotePath(routerState.getSelectedNoteById());
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
          child: AppShell(routerState: routerState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (routerState.selectedNote != null) {
          routerState.selectedNote = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  // @override
  // GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    if (path is HomePath) {
      routerState.navigationIndex = 0;
    } else if (path is SettingsPath) {
      routerState.navigationIndex = 2;
    } else if (path is NotebookPath) {
      routerState.selectedNote = null;
      routerState.navigationIndex = 1;
    } else if (path is NotebookNotePath) {
      routerState.setSelectedNoteById(path.id);
    }
  }
}
