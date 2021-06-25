import 'package:flutter/material.dart';
import '../route_path.dart';
import '../router_state.dart';
import '../../pages/app/app_shell.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  final storage = new FlutterSecureStorage();

  RouterState routerState = RouterState();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    routerState.addListener(notifyListeners);
  }

  RoutePath get currentConfiguration {
    if (routerState.navigationIndex == null) {
      return LoginPath();
    }

    if (routerState.navigationIndex == 0) {
      return HomePath();
    } else if (routerState.navigationIndex == 1) {
      // Handle Notebook notes
      if (routerState.selectedNoteIndex == null) {
        return NotebookPath();
      } else {
        return NotebookNotePath(routerState.selectedNoteIndex);
      }
    } else {
      return GithubPath();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('NotebookPage'),
          child: AppShell(routerState: routerState, storage: storage),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (routerState.selectedNoteIndex != null) {
          routerState.selectedNoteIndex = null;
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
    if (path is LoginPath) {
      routerState.navigationIndex = null;
    } else if (path is HomePath) {
      routerState.navigationIndex = 0;
    } else if (path is GithubPath) {
      routerState.navigationIndex = 2;
    } else if (path is NotebookPath) {
      routerState.selectedNoteIndex = null;
      routerState.navigationIndex = 1;
    } else if (path is NotebookNotePath) {
      routerState.selectedNoteIndex = path.id;
    }
  }
}
