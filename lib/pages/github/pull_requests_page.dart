import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapp2/helpers/checkToken.dart';
import 'package:mapp2/router/router_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PullRequestsPage extends StatelessWidget {
  final RouterState routerState;
  final String repositoryName;
  final FlutterSecureStorage storage;

  final headlineController = TextEditingController();
  final contentController = TextEditingController();
  PullRequestsPage({
    @required this.routerState,
    @required this.storage,
    @required this.repositoryName,
  }) : super(key: ValueKey(repositoryName));

  Future fetchPullRequests() async {
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
            query GetPullRequests(\$name: String!) {
              pullRequests(repositoryName: \$name) {
                title
                body
                comments {
                  body
                  author
                }
              }
            }
          ''',
          'variables': {
            'name': this.repositoryName,
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
          future: fetchPullRequests(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Text('Loading...');
            }

            if (snapshot.data['pullRequests'].length == 0) {
              return Text('No pull requests');
            }
            print(snapshot.data['pullRequests']);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (var pullRequest in snapshot.data['pullRequests'])
                  Column(
                    children: [
                      Card(
                        child: ExpansionTile(
                          title: GestureDetector(
                            child: Text(
                              pullRequest['title'],
                            ),
                          ),
                          backgroundColor: Colors.grey[900],
                          collapsedBackgroundColor: Colors.grey[900],
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 0, 16, 16),
                              title: Text(
                                pullRequest['body'] == '' ||
                                        pullRequest['body'] == null
                                    ? "No body"
                                    : pullRequest['body'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            );
          }),
    );
  }
}
