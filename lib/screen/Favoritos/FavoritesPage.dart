import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> _favorites = [];
  final TextEditingController _searchController = TextEditingController();
  late DatabaseReference _userFavoritesRef;

  @override
  void initState() {
    super.initState();

    // Verificar se o usuário está conectado
    if (_auth.currentUser != null) {
      final user = _auth.currentUser;
      if (user != null) {
        // Configure a referência para os favoritos do usuário no Firebase Realtime Database
        _userFavoritesRef = FirebaseDatabase.instance
            .reference()
            .child('users/${user.uid}/favorites');

        // Obter os favoritos do usuário
        _userFavoritesRef.once().then((DataSnapshot snapshot) {
              final dynamic data = snapshot.value;
              final List<String> userFavorites = [];

              if (data is Map) {
                userFavorites.addAll(data.values.whereType<String>());
              } else if (data is List) {
                userFavorites.addAll(data.whereType<String>());
              }

              setState(() {
                _favorites = userFavorites;
              });
            } as FutureOr Function(DatabaseEvent value));
      }
    }
  }

  void _removeFavorite(int index) {
    // Verificar se o usuário está conectado
    final user = _auth.currentUser;
    if (user != null) {
      // Excluir o favorito
      setState(() {
        _favorites.removeAt(index);
      });

      // Atualizar os favoritos no Firebase
      _userFavoritesRef.set(_favorites);
    }
  }

  void _filterFavorites(String query) {
    // Filtrar os favoritos com base na consulta
    final filteredFavorites =
        _favorites.where((favorite) => favorite.contains(query)).toList();

    setState(() {
      _favorites = filteredFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de pesquisa
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
              ),
              onChanged: (value) {
                // Filtrar os favoritos pelo valor da pesquisa
                _filterFavorites(value);
              },
            ),

            // Lista de favoritos
            Expanded(
              child: ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_favorites[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeFavorite(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FavoritesPage(),
  ));
}
