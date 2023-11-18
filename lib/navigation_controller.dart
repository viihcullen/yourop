import 'package:flutter/material.dart';
import 'package:yourop/screen/Favoritos/favoritos.dart';
import 'package:yourop/screen/Filter/FilterPage.dart';
import 'package:yourop/screen/Home/HomePage.dart';
import 'package:yourop/screen/Perfil/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavigationController extends StatefulWidget {
  @override
  _NavigationControllerState createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavoritosPage(),
    FilterPage(),
    Profile(),
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        animationDuration: Duration(milliseconds: 300),
        onTap: _onItemTapped,
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.filter_alt_outlined, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
