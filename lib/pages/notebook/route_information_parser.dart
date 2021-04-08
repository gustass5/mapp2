import 'package:flutter/widgets.dart';

import './note_route_path.dart';

class NoteRouteInformationParser extends RouteInformationParser<NoteRoutePath> {
  @override
  Future<NoteRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length == 0) {
      return NoteRoutePath.home();
    }
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'note') {
        return NoteRoutePath.unknown();
      }

      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) {
        return NoteRoutePath.unknown();
      }
      return NoteRoutePath.details(id);
    }

    return NoteRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(NoteRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }

    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }

    if (path.isDetailsPage) {
      return RouteInformation(location: 'note/${path.id}');
    }

    return null;
  }
}
