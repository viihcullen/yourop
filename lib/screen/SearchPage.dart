import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

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
              style: TextStyle(color: Colors.black),
              onChanged: _onSearch,
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
              child: ListView.builder(
                itemCount: _getFilteredResults().length,
                itemBuilder: (context, index) {
                  final result = _getFilteredResults()[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://example.com/${result.toLowerCase()}.jpg', // URL da imagem do conteúdo
                      ),
                    ),
                    title: Text(result),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getFilteredResults() {
    return availableContents
        .where((content) =>
            content.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
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
