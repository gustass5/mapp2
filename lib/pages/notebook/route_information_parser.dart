import 'package:flutter/widgets.dart';

import "./note_route_path.dart";

class NoteRouteInformationParser extends RouteInformationParser<NoteRoutePath> {
  @override
  Future<NoteRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      return NotesSettingsPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'note') {
          return NotesDetailsPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return NotesListPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(NoteRoutePath configuration) {
    if (configuration is NotesListPath) {
      return RouteInformation(location: '/home');
    }
    if (configuration is NotesSettingsPath) {
      return RouteInformation(location: '/settings');
    }
    if (configuration is NotesDetailsPath) {
      return RouteInformation(location: '/note/${configuration.id}');
    }
    return null;
  }
}
