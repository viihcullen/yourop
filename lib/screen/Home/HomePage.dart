import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:yourop/services/api_consumer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yourop/services/firebase_actions_user.dart';
import '../ReviewPage/ReviewPage.dart';
import '../Pesquisa/SearchPage.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> obras = [];
  List<Map<String, dynamic>> obraFilmes = [];
  List<Map<String, dynamic>> obrasAnimes = [];
  List<Map<String, dynamic>> obrasDoramas = [];
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
      if (favs.value != null) {
        for (var e in ob) {
           e['favorito'] = (favs.value as List<Object?>).contains(e['idObra']);
        }
      } else {
         for (var e in ob) {
           e['favorito'] = false;
        }
      }
      if (mounted) {
        setState(() {
          obras = ob.cast<Map<String, dynamic>>();
          obraFilmes = obras
              .where((element) =>
                  element['idTipoObra'] ==
                  "58156ce0-a833-4096-821c-2a469b2dec0b")
              .toList();
          obrasAnimes = obras
              .where((element) =>
                  element['idTipoObra'] ==
                  "fd584451-7749-4c3c-be68-5a4e4a4ee8b3")
              .toList();
          obrasDoramas = obras
              .where((element) =>
                  element['idTipoObra'] ==
                  "5491e903-a099-4f07-8d15-0794f85540e2")
              .toList();
        });
      }
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
        shadowColor: Colors.transparent,
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
            _buildContentListObras(),
            _buildCategorySection('Filmes'),
            _buildContentListFilmes(),
            _buildCategorySection('Animes'),
            _buildContentListAnimes(),
            _buildCategorySection('Dramas'),
            _buildContentListDoramas(),
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

  Widget _buildContentListObras() {
    return obras.length > 0
        ? Container(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: obras.length,
              itemBuilder: (context, index) {
                final content = obras[index];
                return GestureDetector(
                  onTap: () {
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
          )
        : Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  child: _buildLoadingContentCard(),
                );
              },
            ));
  }

  Widget _buildContentListFilmes() {
    return obraFilmes.length > 0
        ? Container(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: obraFilmes.length,
              itemBuilder: (context, index) {
                final content = obraFilmes[index];
                return GestureDetector(
                  onTap: () {
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
          )
        : Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  child: _buildLoadingContentCard(),
                );
              },
            ));
  }

  Widget _buildContentListAnimes() {
    return obrasAnimes.length > 0
        ? Container(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: obrasAnimes.length,
              itemBuilder: (context, index) {
                final content = obrasAnimes[index];
                return GestureDetector(
                  onTap: () {
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
          )
        : Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  child: _buildLoadingContentCard(),
                );
              },
            ));
  }

  Widget _buildContentListDoramas() {
    return obrasDoramas.length > 0
        ? Container(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: obrasDoramas.length,
              itemBuilder: (context, index) {
                final content = obrasDoramas[index];
                return GestureDetector(
                  onTap: () {
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
          )
        : Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  child: _buildLoadingContentCard(),
                );
              },
            ));
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ClipRRect(
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
                )),
          ],
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
                FirebaseActionsUser.favoritar(
                    content['idObra'], content['favorito']);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingContentCard() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ],
        ));
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

class ShinyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Container 1
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              // Container 2
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              // Container 3
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
