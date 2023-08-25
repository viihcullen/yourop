import 'package:flutter/material.dart';
import 'SearchPage.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedCategoria = [];
  List<String> selectedGeneros = [];

  final List<String> availableGeneros = [
    'Ação',
    'Aventura',
    'Comédia',
    'Drama',
    'Ficção Científica',
    'Fantasia',
    'Terror',
    'Romance',
    'Documentário',
    'Animação',
    'Mistério',
    'Suspense',
    'Crime',
    'Musical',
    'História',
    'Biografia',
    'Esportes',
    'Família',
  ];
  final List<String> availableCategoria = [
    'Games',
    'Filmes e Séries',
    'Animes',
    'Dramas',
  ];

  void _toggleGeneros(String genero) {
    setState(() {
      if (selectedGeneros.contains(genero)) {
        selectedGeneros.remove(genero);
      } else {
        selectedGeneros.add(genero);
      }
    });
  }

  void _toggleCategoria(String categoria) {
    setState(() {
      if (selectedCategoria.contains(categoria)) {
        selectedCategoria.remove(categoria);
      } else {
        selectedCategoria.add(categoria);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            child: Ink(
              decoration: const ShapeDecoration(
                shadows: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 2.0)
                ],
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                padding: const EdgeInsets.all(10.0),
                onPressed: () {
                  _navigate(context);
                },
                iconSize: 30,
              ),
            ),
          ),
          const Text(
            'Categoria',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableCategoria.length,
              itemBuilder: (context, index) {
                final categoria = availableCategoria[index];
                return CheckboxListTile(
                  title: Text(categoria),
                  value: selectedCategoria.contains(categoria),
                  onChanged: (value) {
                    _toggleCategoria(categoria);
                  },
                );
              },
            ),
          ),
          const Text(
            'Selecione os filtros',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableGeneros.length,
              itemBuilder: (context, index) {
                final genero = availableGeneros[index];
                return CheckboxListTile(
                  title: Text(genero),
                  value: selectedGeneros.contains(genero),
                  onChanged: (value) {
                    _toggleGeneros(genero);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Aplicar Filtros'),
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }
}
