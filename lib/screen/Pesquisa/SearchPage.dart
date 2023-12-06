import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourop/screen/ReviewPage/ReviewPage.dart';
import 'package:yourop/services/api_consumer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool onSearching = false;
  TextEditingController searchQueryController = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: new Icon(Icons.arrow_back),
              alignment: Alignment.bottomLeft,
              padding: new EdgeInsets.all(5.0),
              onPressed: () {
                _navigate(context);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: searchQueryController,
              onEditingComplete: _getFilteredResults,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.grey.shade700,
                suffixIcon: Icon(Icons.mic),
                suffixIconColor: Colors.grey.shade700,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: !onSearching?(
                searchResult.length>0?ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  final result = searchResult[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        result['imageURL'], // URL da imagem do conteúdo
                      ),
                    ),
                    title: Text(result['tituloObra'].toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewPage(obra: result)),
                      );
                    },
                  );
                },
              ): Container(
                alignment: Alignment.center,
                child: Text("Nenhum resultado encontrado"),
              )
              ):Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getFilteredResults() async {
    FocusScope.of(context).unfocus();
    setState(() {
    onSearching = true;
    });

    var res = await API.searchForTerm(searchQueryController.text);

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body) as List<dynamic>;
      setState(() {
        searchResult = result.cast<Map<String, dynamic>>();
        onSearching = false;
      });
    }
  }

  final List<String> availableContents = [
    'Game A',
    'Filme B',
    'Série C',
    // Adicione mais conteúdos disponíveis aqui
  ];

  void _navigate(BuildContext context) {
    Navigator.of(context).pop();
  }
}
