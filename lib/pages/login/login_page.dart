import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mapp2/router/router_state.dart';

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3001/auth/login'),
    // Uri.parse('http://localhost:3001/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Login failed');
  }
}

class LoginPage extends StatelessWidget {
  final RouterState routerState;

  final FlutterSecureStorage storage;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({@required this.routerState, @required this.storage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
              child: TextButton(
                onPressed: () async {
                  Map<String, dynamic> response = await login(
                      usernameController.text, passwordController.text);
                  await storage.write(
                      key: 'accessToken', value: response['accessToken']);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Login successful'),
                      );
                    },
                  );
                  routerState.navigationIndex = 2;
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.cyan),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
