import 'package:flutter/material.dart';

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
