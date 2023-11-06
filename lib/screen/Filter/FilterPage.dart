import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yourop/models/obra.dart';
import 'package:yourop/screen/Filter/ResultPage.dart';
import 'package:yourop/screen/Pesquisa/SearchPage.dart';
import 'package:http/http.dart';
import 'package:yourop/services/api_consumer.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedCategoria = [];
  List<String> selectedGeneros = [];

  List<Map<String, dynamic>> availableGeneros = [];
  List<Map<String, dynamic>> availableCategoria = [];

  void loadGeneros() async{
    Response res = await API.getCategorias();
    if(res.statusCode == 200){
      List<dynamic> gens = jsonDecode(res.body);
      if(mounted){
      setState(() {
        availableGeneros = gens.cast<Map<String, dynamic>>();
      });
      }
    }
  }

  void loadCategorias() async{
    Response res = await API.getTipoObras();
    if(res.statusCode == 200){
      List<dynamic> tips = jsonDecode(res.body);
      if(mounted){
      setState(() {
        availableCategoria = tips.cast<Map<String, dynamic>>();
      });
      }
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
    loadCategorias();
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
                    blurRadius: 2.0,
                  ),
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
                  title: Text(categoria['nomeTipo']),
                  value: selectedCategoria.contains(categoria['idTipoObra']),
                  onChanged: (value) {
                    _toggleCategoria(categoria['idTipoObra']);
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
              onPressed: () async {
                // Aqui você pode aplicar os filtros e navegar para a página de resultados.
                print(selectedCategoria);
                print(selectedGeneros);
                List<dynamic> searchResult = [];
                if(selectedCategoria.length > 0 && selectedGeneros.length > 0){
                searchResult = jsonDecode((await API.searchFilter(selectedGeneros, selectedCategoria)).body);
                }else{
                  if(selectedCategoria.length > 0){
                    searchResult = jsonDecode((await API.searchForTipoObra(selectedCategoria)).body);
                  }else if(selectedGeneros.length > 0){
                    searchResult = jsonDecode((await API.searchForCategoria(selectedGeneros)).body);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Selecione um filtro")));
                  }
                }
                _navigateToSearchResults(searchResult.cast<Map<String, dynamic>>());
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

  void _navigateToSearchResults(List<Map<String, dynamic>> filteredObras) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchResultsPage(filteredObras: filteredObras)));
  }
}
