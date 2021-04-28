import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './notebook_state.dart';

class NotebookNotePage extends StatelessWidget {
  final int noteIndex;

  final headlineController = TextEditingController();
  final contentController = TextEditingController();
  NotebookNotePage({
    this.noteIndex,
  }) : super(key: ValueKey(noteIndex));

  @override
  Widget build(BuildContext context) {
    var notebookState = context.read<NotebookState>();
    var note = notebookState.notes[noteIndex];
    headlineController.text = note.headline;
    contentController.text = note.content;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note != null) ...[
              TextField(
                controller: headlineController,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                ),
              ),
              TextField(
                controller: contentController,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notebookState.updateNote(noteIndex, headlineController.text,
              contentController.text, '2021-02-12');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text('Note updated'),
              );
            },
          );
        },
        child: new Icon(Icons.check),
        backgroundColor: Colors.pink[500],
      ),
    );
  }
}
