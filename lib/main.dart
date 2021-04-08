import 'package:flutter/material.dart';
import './pages/notebook/note_router_delegate.dart';
import './pages/notebook/route_information_parser.dart';

void main() {
  runApp(Root());
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  NoteRouterDelegate _routerDelegate = NoteRouterDelegate();
  NoteRouteInformationParser _routeInformationParser =
      NoteRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mapp',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
