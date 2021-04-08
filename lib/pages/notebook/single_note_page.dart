import 'package:flutter/material.dart';
import 'single_note_screen.dart';
import 'note.dart';

class SingleNotePage extends Page {
  final Note note;

  SingleNotePage({
    this.note,
  }) : super(key: ValueKey(note));

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: SingleNoteScreen(
            note: note,
          ),
        );
      },
    );
  }
}
