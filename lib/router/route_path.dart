abstract class RoutePath {}

class LoginPath extends RoutePath {}

class HomePath extends RoutePath {}

class SettingsPath extends RoutePath {}

class NotebookPath extends RoutePath {}

class NotebookNotePath extends RoutePath {
  final int id;

  NotebookNotePath(this.id);
}
