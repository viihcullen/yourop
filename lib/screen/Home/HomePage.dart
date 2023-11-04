import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:yourop/models/Obra.dart';
import 'package:yourop/services/api_consumer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yourop/services/firebase_actions_user.dart';
import '../../models/content.dart';
import '../ReviewPage/ReviewPage.dart';
import '../Pesquisa/SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Content> availableContents = [];
  List<Map<String, dynamic>> obras = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    getObra();
  }

  void getObra() async {
    Response obrasRes = await API.getObras();
    List<dynamic> ob = jsonDecode(obrasRes.body);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var favs = await (FirebaseDatabase.instance
              .ref()
              .child("/users/${user.uid}/favoritos"))
          .get();
      List<dynamic> obsFavs = ob.map((e) {
        e['favorito'] = (favs.value as List<Object?>).contains(e['idObra']);
        return e;
      }).toList();
      setState(() {
        obras = ob.cast<Map<String, dynamic>>();
      });
    }
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }

  void _navigateToReviewPage(
      BuildContext context, Map<String, dynamic> content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(obra: content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Alterar a cor do appbar
      appBar: AppBar(
        title: Text('YourOP'),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
      ),
      // Adicionar uma barra de pesquisa
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Adicionar uma seção de bem-vindo
          Container(
            width: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: Text(
              'Bem-Vindo, \n ${_user?.displayName ?? 'Usuário'} !!!',
              style: GoogleFonts.sacramento(
                textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
              /*TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black, // Alterado para preto
              ),*/
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: obras.length,
              itemBuilder: (context, index) {
                final content = obras[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      content['favorito'] = !content['favorito'];
                    });
                    _navigateToReviewPage(context, content);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    width: 100,
                    child: _buildContentCard(content),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Alterar a imagem do conteúdo para um tamanho maior
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: content['imageURL'] != null
              ? Image.network(
                  content['imageURL'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        SizedBox(
          height: 10,
        ),
        // Alterar o título do conteúdo para maior e com fonte Roboto
        Text(
          content['tituloObra'],
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              content['favorito'] ? Icons.favorite : Icons.favorite_border,
              color: content['favorito'] ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                content['favorito'] = !content['favorito'];
                FirebaseActionsUser.favoritar(content['idObra'], content['favorito']);
              });
            },
          ),
        ),
      ],
    );
  }

  // Alterar o método `_getUserInfo()` para retornar o nome do usuário
  void _getUserInfo() async {
    _user = await _auth.currentUser;
    if (_user != null) {
      setState(() {
        // Alterar o nome do usuário na seção de bem-vindo
        _user?.displayName;
      });
    }
  }
}
