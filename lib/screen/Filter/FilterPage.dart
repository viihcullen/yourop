import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yourop/services/api_consumer.dart';
import '../Pesquisa/SearchPage.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedCategoria = [];
  List<String> selectedGeneros = [];

  List<Map<String, dynamic>> availableGeneros = [];
  final List<String> availableCategoria = [
    'Games',
    'Filmes e Séries',
    'Animes',
    'Dramas',
  ];

  void loadGeneros() async{
    Response res = await API.getCategorias();
    if(res.statusCode == 200){
      List<dynamic> gens = jsonDecode(res.body);
      setState(() {
        availableGeneros = gens.cast<Map<String, dynamic>>();
      });
    }
  }

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
  void initState() {
    super.initState();
    loadGeneros();
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
                  title: Text(genero['nomeCategoria']!),
                  value: selectedGeneros.contains(genero['idCategoria']),
                  onChanged: (value) {
                    _toggleGeneros(genero['idCategoria']!);
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
