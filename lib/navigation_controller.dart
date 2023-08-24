import 'package:flutter/material.dart';
import 'package:yourop/screen/FavoritesPage.dart';
import 'package:yourop/screen/FilterPage.dart';
import 'package:yourop/screen/HomePage.dart';
import 'package:yourop/screen/ProfilePage.dart';

class NavigationController extends StatefulWidget {
  @override
  _NavigationControllerState createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavoritesScreen(),
    FilterPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter, color: Colors.black), label: "Filter"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black), label: "User"),
        ],
      ),
    );
  }
}
