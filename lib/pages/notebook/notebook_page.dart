import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapp2/helpers/checkToken.dart';
import './note.dart';
import '../../router/router_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotebookPage extends StatelessWidget {
  final RouterState routerState;
  final FlutterSecureStorage storage;
  final ValueChanged<int> onTapped;
  NotebookPage({
    @required this.routerState,
    @required this.storage,
    @required this.onTapped,
  });

  Future fetchNotes() async {
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
            query GetNotes{
              notes{
                id
                headline
                content
                creationDate
              }
            }
          ''',
        },
      ),
    );
    return json.decode(response.body)['data'];
  }

  Future createNote() async {
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
            mutation CreateNote(\$input: NoteInput!){
              createNote(input: \$input){
                id
            }
          }
        ''',
          'variables': {
            'input': {
              'headline': 'New',
              'content': '',
              'creationDate': '',
            },
          }
        },
      ),
    );

    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [],
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (var note in snapshot.data['notes'])
                Column(
                  children: [
                    Card(
                      child: ExpansionTile(
                        title: GestureDetector(
                          onTap: () => onTapped(int.parse(note['id'])),
                          child: Text(
                            note['headline'],
                          ),
                        ),
                        backgroundColor: Colors.grey[900],
                        collapsedBackgroundColor: Colors.grey[900],
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            title: Text(
                              note['content'],
                            ),
                            subtitle: Text(note['creationDate']),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await createNote();
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.pink[500],
      ),
    );
  }
}
