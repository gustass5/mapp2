class NoteRoutePath {
  final int id;
  final bool isUnknown;

  NoteRoutePath.home()
      : id = null,
        isUnknown = false;

  NoteRoutePath.details(this.id) : isUnknown = false;

  NoteRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;
  bool get isDetailsPage => id != null;
}
/**
 * In this app, all of the routes in the app can be represented using a single class.
 * Instead, you might choose to use different classes that implement a superclass, or manage the route information in another way.
 */
