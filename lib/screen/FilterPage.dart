import 'package:flutter/material.dart';
import 'SearchPage.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedGenres = [];

  final List<String> availableGenres = [
    'Ação',
    'Drama',
    'Comédia',
    'Fantasia',
    // Adicione mais gêneros aqui
  ];

  void _toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.search),
            alignment: Alignment.bottomRight,
            padding: new EdgeInsets.all(5.0),
            onPressed: () {
              _navigate(context);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableGenres.length,
              itemBuilder: (context, index) {
                final genre = availableGenres[index];
                return CheckboxListTile(
                  title: Text(genre),
                  value: selectedGenres.contains(genre),
                  onChanged: (value) {
                    _toggleGenre(genre);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Aplicar os filtros selecionados
              },
              child: Text('Aplicar Filtros'),
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
