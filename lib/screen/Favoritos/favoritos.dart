import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yourop/screen/ReviewPage/ReviewPage.dart';
import 'package:yourop/services/api_consumer.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<Map<String, dynamic>> favoritos = [];

  getFavoritos() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var favs = await (FirebaseDatabase.instance
              .ref()
              .child("/users/${user.uid}/favoritos"))
          .get();
      List<Map<String, dynamic>> favorits = [];
      if (favs.value != null) {
        for (var i = 0; i < (favs.value as List<Object?>).length; i++) {
          var v =
              await API.getObra((favs.value as List<Object?>)[i].toString());
          favorits.add(jsonDecode(v.body));
        }
      }
      if (mounted) {
        setState(() {
          favoritos = favorits;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minha Biblioteca',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
            color: Colors.black,
            iconSize: 25,
          )
        ],
      ),
      body: Center(
        child: favoritos.length==0?CircularProgressIndicator():Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: favoritos.map((conteudo) {
                      return FavoritoCard(
                        conteudo: conteudo,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConteudoFavorito {
  final String title;
  final String imagemUrl;

  ConteudoFavorito({
    required this.title,
    required this.imagemUrl,
  });
}

class FavoritoCard extends StatelessWidget {
  final Map<String, dynamic> conteudo;

  FavoritoCard({
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReviewPage(obra: this.conteudo)),
        );
      },
      child: SizedBox(
        width:
            (MediaQuery.of(context).size.width - 30.0) / 3, // 3 itens por linha
        height: 210,
        child: Card(
          elevation: 2.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                conteudo['imageURL'],
                height: 100.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  conteudo['tituloObra'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
