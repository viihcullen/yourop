import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  final List<ConteudoFavorito> favoritos = [
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    ConteudoFavorito(
      title: 'Game A',
      imagemUrl:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text('aldfkjhwejhh'),
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
  final ConteudoFavorito conteudo;

  FavoritoCard({
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          (MediaQuery.of(context).size.width - 30.0) / 3, // 3 itens por linha
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              conteudo.imagemUrl,
              height: 100.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                conteudo.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
