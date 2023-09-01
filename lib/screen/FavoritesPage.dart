import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favoriteContents = [
    'Game A',
    'Filme B',
    // Adicione mais conteúdos favoritos aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: favoriteContents.length,
        itemBuilder: (context, index) {
          final content = favoriteContents[index];
          return ListTile(
            title: Text(content),
          );
        },
      ),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).pop();
  }
}
