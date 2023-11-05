import 'package:flutter/material.dart';
import 'package:yourop/models/obra.dart';
import 'package:yourop/screen/ReviewPage/ReviewPage.dart'; // Importe seu modelo Obra

class SearchResultsPage extends StatefulWidget {
  final List<Obra> filteredObras;

  SearchResultsPage({required this.filteredObras});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  void _navigateToReviewPage(
      BuildContext context, Map<String, dynamic> content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(obra: content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados da Busca',
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.filteredObras.length,
        itemBuilder: (context, index) {
          final obra = widget.filteredObras[index];
          return GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: obra.imageUrl != null
                  ? Image.network(obra.imageUrl!)
                  : Placeholder(),
              title: Text(obra.tituloObra ?? ''),
              subtitle: Text(obra.resumoObra ?? ''),
            ),
          );
        },
      ),
    );
  }
}
