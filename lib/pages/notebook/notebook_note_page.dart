import 'package:flutter/material.dart';
import 'note.dart';

class NotebookNotePage extends StatelessWidget {
  final Note note;

  NotebookNotePage({
    this.note,
  }) : super(key: ValueKey(note));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
