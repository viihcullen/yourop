import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:yourop/models/Obra.dart';
import 'package:yourop/services/api_consumer.dart';

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
    setState(() {
    obras = ob.cast<Map<String, dynamic>>();
    });
  }

  void _getUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }

  void _navigateToReviewPage(BuildContext context, Map<String, dynamic> content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(obra: content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Text(
              'Bem-Vindo, ${_user?.displayName ?? 'Usuário'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Alterado para preto
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Talvez você goste',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 100,
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
                    width: 100,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            child: content['imageURL']!=null?Image.network(
                              content['imageURL'],
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ): null,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.black.withOpacity(0.7),
                          child: Text(
                            content['tituloObra'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            /*ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableContents.length,
              itemBuilder: (context, index) {
                final content = availableContents[index];
                return GestureDetector(
                  onTap: () {
                    _navigateToReviewPage(context, content);
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              content.imageUrl,
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.black.withOpacity(0.7),
                          child: Text(
                            content.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),*/
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
