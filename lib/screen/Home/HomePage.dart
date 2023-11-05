import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:yourop/models/content.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () => _navigateToSearchPage(context),
            icon: Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bem-Vindo, ${_user?.displayName ?? 'Usuário'} !!!',
                style: GoogleFonts.sacramento(
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _buildCategorySection('Talvez você goste'),
            _buildContentList(),
            _buildCategorySection('Filmes'),
            _buildContentList(),
            _buildCategorySection('Animes'),
            _buildContentList(),
            _buildCategorySection('Doramas'),
            _buildContentList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        category,
        style: GoogleFonts.robotoSerif(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildContentList() {
    return Container(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: obras.length,
        itemBuilder: (context, index) {
          final content = obras[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                content['favorito'] = !content['favorito'];
                FirebaseActionsUser.favoritar(
                    content['idObra'], content['favorito']);
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
    );
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: content['imageURL'] != null
              ? Image.network(
                  content['imageURL'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : Placeholder(),
        ),
        SizedBox(height: 10),
            Text(content['tituloObra'],
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )),],
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
                  });
                },
              ),
            ),
          
      ],
    );
  }

  void _getUserInfo() async {
    _user = await _auth.currentUser;
    if (_user != null) {
      setState(() {
        _user?.displayName;
      });
    }
  }
}
