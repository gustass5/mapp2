// Widget that contains the AdaptiveNavigationScaffold
import 'package:flutter/material.dart';
import '../../router/router_state.dart';
import '../../router/content_router/content_router_delegate.dart';
import './widgets/bottom_navigation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppShell extends StatefulWidget {
  final RouterState routerState;
  final FlutterSecureStorage storage;

  AppShell({
    @required this.routerState,
    @required this.storage,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  ContentRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = ContentRouterDelegate(widget.routerState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.routerState = widget.routerState;
    _routerDelegate.storage = widget.storage;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var routerState = widget.routerState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapp'),
      ),
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      bottomNavigationBar: routerState.navigationIndex != null
          ? BottomNavigation(routerState: routerState)
          : null,
    );
  }
}
