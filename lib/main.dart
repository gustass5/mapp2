import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapp',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapp'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 64.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: Text(
                  'Mapp Drawer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Notifications'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Info'),
            ),
            ListTile(
              leading: Icon(Icons.ramen_dining),
              title: Text('Whatever'),
            ),
          ],
        ),
      ),
      body: NotebookPage(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 1;

  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onNavigationItemTapped,
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.pink,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.notes),
          label: "Notebook",
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.list),
          label: "List",
        ),
      ],
    );
  }
}

class NotebookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Note(),
        Note(headline: "Headline"),
        Note(headline: "Test text"),
      ],
    );
  }
}

class Note extends StatefulWidget {
  final String headline;
  final String text =
      'Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text';

  Note({Key key, this.headline = 'Test'}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ExpansionTile(
            title: Text(
              widget.headline,
            ),
            backgroundColor: Colors.grey[900],
            collapsedBackgroundColor: Colors.grey[900],
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                title: Text(
                  widget.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
