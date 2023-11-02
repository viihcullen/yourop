import 'package:flutter/material.dart';
import 'package:yourop/screen/Favoritos/favoritos.dart';
import 'package:yourop/screen/Filter/FilterPage.dart';
import 'package:yourop/screen/Home/HomePage.dart';
import 'package:yourop/screen/Home/hometeste.dart';
import 'package:yourop/screen/Perfil/Profile.dart';

class NavigationController extends StatefulWidget {
  @override
  _NavigationControllerState createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageTeste(),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt_outlined, color: Colors.black),
              label: "Filter"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black), label: "User"),
        ],
      ),
    );
  }
}
