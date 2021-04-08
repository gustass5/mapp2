import 'package:flutter/material.dart';
import "note.dart";

class SingleNoteScreen extends StatelessWidget {
  final Note note;

  SingleNoteScreen({
    @required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note != null) ...[
              Text(note.headline, style: Theme.of(context).textTheme.headline6),
              Text(note.content, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
