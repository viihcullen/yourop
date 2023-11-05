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
      body:  ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.filteredObras.length,
        itemBuilder: (context, index) {
          final obra = widget.filteredObras[index];
          obra.imageUrl = "https://firebasestorage.googleapis.com/v0/b/db-yourop.appspot.com/o/obra_images%2F013af216-fa7b-4b3d-88dc-61c957a7a0ae.jpeg?alt=media&token=62aa0c85-cdac-4cb3-a2a4-cb8468d88dee&_gl=1*png1k9*_ga*ODg3NjE3NzIuMTY5ODEwODMwNw..*_ga_CW55HF8NVT*MTY5OTA0NjQ1Ny44LjEuMTY5OTA0NzMwMi41OS4wLjA";
          return Container(
            height: 150,
        child: ListTile(
      
            leading: obra.imageUrl != null
                ? Image.network(obra.imageUrl!)
                : null,
            title: Text(obra.tituloObra ?? ''),
            subtitle: Text(obra.resumoObra ?? ''),
            onTap: () {},
          )
          );
        },
      ),
    );
  }
}
