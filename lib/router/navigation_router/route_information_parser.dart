import 'package:flutter/widgets.dart';

import "../route_path.dart";

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'home') {
      return HomePath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'github') {
      return GithubPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'notebook') {
          return NotebookNotePath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return NotebookPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration is LoginPath) {
      return RouteInformation(location: '/login');
    }
    if (configuration is HomePath) {
      return RouteInformation(location: '/home');
    }
    if (configuration is GithubPath) {
      return RouteInformation(location: '/github');
    }
    if (configuration is NotebookPath) {
      return RouteInformation(location: '/notebook');
    }
    if (configuration is NotebookNotePath) {
      return RouteInformation(location: '/notebook/${configuration.id}');
    }
    return null;
  }
}
