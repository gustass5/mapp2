abstract class NoteRoutePath {}

class NotesListPath extends NoteRoutePath {}

class NotesSettingsPath extends NoteRoutePath {}

class NotesDetailsPath extends NoteRoutePath {
  final int id;

  NotesDetailsPath(this.id);
}
