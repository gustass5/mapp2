import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapp2/helpers/checkToken.dart';
import '../../router/router_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubPage extends StatelessWidget {
  final RouterState routerState;
  final FlutterSecureStorage storage;
  final ValueChanged<String> onTapped;
  GithubPage({
    @required this.routerState,
    @required this.storage,
    @required this.onTapped,
  });

  Future fetchRepositories() async {
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
            query GetRepositories{
              repositories {
                name
                owner
              }
            }
          ''',
        },
      ),
    );
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchRepositories(),
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
              for (var repo in snapshot.data['repositories'])
                Column(
                  children: [
                    Card(
                      child: ListTile(
                        onTap: () => onTapped(repo['name']),
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        title: Text(
                          repo['name'],
                        ),
                        subtitle: Text(repo['owner']),
                      ),
                    ),
                  ],
                )
            ],
          );
        },
      ),
    );
  }
}
