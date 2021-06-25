import 'package:flutter/material.dart';
import '../../../router/router_state.dart';

class BottomNavigation extends StatelessWidget {
  final RouterState routerState;
  BottomNavigation({
    @required this.routerState,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: routerState.navigationIndex,
      onTap: (newIndex) {
        routerState.navigationIndex = newIndex;
      },
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
          icon: new Icon(Icons.code),
          label: "Github",
        ),
      ],
    );
  }
}
