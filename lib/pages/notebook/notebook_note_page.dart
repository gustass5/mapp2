import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapp2/helpers/checkToken.dart';
import 'package:mapp2/router/router_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotebookNotePage extends StatelessWidget {
  final RouterState routerState;
  final int noteIndex;
  final FlutterSecureStorage storage;

  final headlineController = TextEditingController();
  final contentController = TextEditingController();
  NotebookNotePage({
    @required this.routerState,
    @required this.storage,
    @required this.noteIndex,
  }) : super(key: ValueKey(noteIndex));

  Future fetchNote() async {
    String token = await storage.read(key: "accessToken");
    checkToken(token, routerState);
    var response = await http.post(
      Uri.parse('http://10.0.2.2:3001/graphql'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'query': ''' 
            query GetSingleNote(\$id: Int){
              notes(id: \$id){
                id
                headline
                content
                creationDate
              }
            }
          ''',
          'variables': {'id': this.noteIndex}
        },
      ),
    );

    return json.decode(response.body)['data'];
  }

  Future updateNote(headline, content) async {
    String token = await storage.read(key: 'accessToken');
    checkToken(token, routerState);

    var response = await http.post(
      Uri.parse('http://10.0.2.2:3001/graphql'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'query': '''
            mutation UpdateNote(\$input: NoteInput!){
              updateNote(input: \$input){
                id
                headline
                content
            }
          }
        ''',
          'variables': {
            'input': {
              'id': this.noteIndex,
              'headline': headline,
              'content': content,
              'updateDate': '',
            },
          }
        },
      ),
    );

    return json.decode(response.body)['data'];
  }

  Future deleteNote() async {
    String token = await storage.read(key: 'accessToken');
    checkToken(token, routerState);

    var response = await http.post(
      Uri.parse('http://10.0.2.2:3001/graphql'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'query': '''
            mutation DeleteNote(\$id: Int){
              deleteNote(id: \$id){
                id
                headline
            }
          }
        ''',
          'variables': {
            'id': this.noteIndex,
          }
        },
      ),
    );

    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                return showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Warning'),
                    content:
                        const Text('Do you really want to delete this note?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await deleteNote();
                          Navigator.pop(context);
                          routerState.navigationIndex = 1;
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: FutureBuilder(
          future: fetchNote(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Text('Loading...');
            }

            headlineController.text = snapshot.data['notes'][0]['headline'];
            contentController.text = snapshot.data['notes'][0]['content'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (snapshot.data['notes'][0] != null) ...[
                    TextField(
                      controller: headlineController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
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
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await updateNote(headlineController.text, contentController.text);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Note updated')));
        },
        child: new Icon(Icons.check),
        backgroundColor: Colors.pink[500],
      ),
    );
  }
}
