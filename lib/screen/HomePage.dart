import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/content.dart';
import 'ReviewPage/ReviewPage.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Content> availableContents = [
    Content(
      title: 'Game A',
      genre: ['Ação'],
      creator: 'jnjhgjhg',
      nationality: "",
      imageUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
      categories: [
        'Categoria1',
        'Categoria2'
      ], // Adicione as categorias desejadas aqui
      description: 'Descrição do Game A',
      releaseYear: 2019,
      authorsOrProducers: 'Nome do Autor/Produtor',
      betaReview: 'Revisão Beta do Game A',
      comments: [
        Comment(username: 'Usuário1', text: 'Comentário 1'),
        Comment(username: 'Usuário2', text: 'Comentário 2'),
      ],
    ),
    Content(
      title: 'Barbie',
      genre: ['Comédia'],
      creator: 'njhbhgfhg',
      nationality: "",
      imageUrl:
          'https://i.pinimg.com/564x/e5/62/90/e56290a55446b17c9ad17cfa93a87300.jpg',
      categories: [
        'Categoria1',
        'Categoria2'
      ], // Adicione as categorias desejadas aqui
      description: 'Descrição do Game A',
      releaseYear: 2019,
      authorsOrProducers: 'Nome do Autor/Produtor',
      betaReview: 'Revisão Beta do Game A',
      comments: [
        Comment(username: 'Usuário1', text: 'Comentário 1'),
        Comment(username: 'Usuário2', text: 'Comentário 2'),
      ],
    ),
    Content(
      title: 'Euphoria',
      genre: ['Drama'],
      creator: 'nsdfhjgjuhy',
      nationality: "",
      imageUrl:
          'https://i.pinimg.com/564x/ac/e4/ac/ace4ac67522fd1ddbe5a8770c88122bd.jpg',
      categories: [
        'Categoria1',
        'Categoria2'
      ], // Adicione as categorias desejadas aqui
      description: 'Descrição do Game A',
      releaseYear: 2019,
      authorsOrProducers: 'Nome do Autor/Produtor',
      betaReview: 'Revisão Beta do Game A',
      comments: [
        Comment(username: 'Usuário1', text: 'Comentário 1'),
        Comment(username: 'Usuário2', text: 'Comentário 2'),
      ],
    ),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
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

  void _navigateToReviewPage(BuildContext context, Content content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(content: content)),
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
            color: Colors.blue, // Cor de fundo da mensagem de boas-vindas
            child: Text(
              'Bem-Vindo, ${_user?.displayName ?? 'Usuário'}', // Alterado para tratar _user como nulo
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Cor do texto da mensagem
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableContents.length,
              itemBuilder: (context, index) {
                final content = availableContents[index];
                return GestureDetector(
                  onTap: () {
                    _navigateToReviewPage(context, content);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.network(
                            content.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
