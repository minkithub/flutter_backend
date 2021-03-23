import 'package:flutter/material.dart';
import 'package:simplenote/pages/note_page.dart';
import 'package:simplenote/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [NotesPage(), ProfilePage()];

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedindex) {
    return BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: selectedindex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile')
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }
}
