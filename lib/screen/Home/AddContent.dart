import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddContentPage extends StatefulWidget {
  @override
  _AddContentPageState createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  final String _apiUrl =
      'https://youropapi-6dd8933b8ff5.herokuapp.com/api/v1/obra';
  final String _apiKey = 'your_api_key';

  String _tituloObra = '';
  String _descricaoObra = '';
  String _resumoObra = '';
  String? _imagem;
  String? _autores;
  String? _diretor;
  String? _escritor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Conteúdo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // Título da Obra
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título da Obra',
                ),
                onChanged: (value) {
                  _tituloObra = value;
                },
              ),
            ),
            // Imagem da Obra
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Imagem da Obra',
                ),
                onChanged: (value) {
                  _imagem = value;
                },
              ),
            ),
            // Autores
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Autores',
                ),
                onChanged: (value) {
                  _autores = value;
                },
              ),
            ),
            // Resumo
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Resumo',
                ),
                onChanged: (value) {
                  _resumoObra = value;
                },
              ),
            ),
            // Diretor
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Diretor',
                ),
                onChanged: (value) {
                  _diretor = value;
                },
              ),
            ),
            // Escritor
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Escritor',
                ),
                onChanged: (value) {
                  _escritor = value;
                },
              ),
            ),
            // Botão de adicionar
            ElevatedButton(
              onPressed: () async {
                // Adicionar o conteúdo à API
                Map<String, dynamic> content = {
                  'tituloObra': _tituloObra,
                  'descricaoObra':
                      _descricaoObra, // Está faltando o valor da descrição
                  'imagem': _imagem,
                  'autores': _autores,
                  'resumo': _resumoObra,
                  'diretor': _diretor,
                  'escritor': _escritor,
                };

                // Chamar a função then() antes da chamada à API HTTP
                http
                    .post(
                  Uri.parse(_apiUrl),
                  headers: {'Authorization': 'Bearer $_apiKey'},
                  body: jsonEncode(content),
                )
                    .then((response) {
                  // Navegar para a página anterior, mesmo que a chamada à API HTTP falhe
                  Navigator.pop(context);
                });
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
