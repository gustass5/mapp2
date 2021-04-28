import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './router/navigation_router/note_router_delegate.dart';
import './router/navigation_router/route_information_parser.dart';
import './pages/notebook/notebook_state.dart';

void main() {
  runApp(Root());
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NotebookState(),
        child: MaterialApp.router(
          title: 'Mapp',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.pink,
          ),
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        ));
  }
}
