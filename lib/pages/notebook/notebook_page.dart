import 'package:flutter/material.dart';
import './note.dart';

class NotebookPage extends StatelessWidget {
  final List<Note> notes;
  final ValueChanged<Note> onTapped;
  NotebookPage({
    @required this.notes,
    @required this.onTapped,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapp'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (var note in notes)
            Column(
              children: [
                Card(
                  child: ExpansionTile(
                    title: GestureDetector(
                      onTap: () => onTapped(note),
                      child: Text(
                        note.headline,
                      ),
                    ),
                    backgroundColor: Colors.grey[900],
                    collapsedBackgroundColor: Colors.grey[900],
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        title: Text(
                          note.content,
                        ),
                        subtitle: Text(note.creationDate),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
