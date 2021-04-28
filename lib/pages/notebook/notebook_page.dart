import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './notebook_state.dart';
import './note.dart';
import '../../router/router_state.dart';

class NotebookPage extends StatelessWidget {
  final RouterState routerState;
  final List<Note> notes;
  final ValueChanged<int> onTapped;
  NotebookPage({
    @required this.routerState,
    @required this.notes,
    @required this.onTapped,
  });
  @override
  Widget build(BuildContext context) {
    var notebookState = context.watch<NotebookState>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Mapp'),
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (var note in notebookState.notes)
            Column(
              children: [
                Card(
                  child: ExpansionTile(
                    title: GestureDetector(
                      onTap: () => onTapped(notes.indexOf(note)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int index = notebookState.createNote();
          routerState.selectedNoteIndex = index;
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.pink[500],
      ),
    );
  }
}
