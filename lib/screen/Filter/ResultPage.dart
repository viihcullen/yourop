import 'package:flutter/material.dart';
import 'package:yourop/models/obra.dart';
import 'package:yourop/screen/ReviewPage/ReviewPage.dart'; // Importe seu modelo Obra

class SearchResultsPage extends StatefulWidget {
  final List<Map<String, dynamic>> filteredObras;

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
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: widget.filteredObras.length>0?ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.filteredObras.length,
        itemBuilder: (context, index) {
          final obra = widget.filteredObras[index];
        return Container(
          alignment: Alignment.center,
              height: 70,
              child: ListTile(
                leading: obra['imageURL'] != null
                    ? Image.network(obra['imageURL']!)
                    : null,
                title: Text(obra['tituloObra'] ?? ''),
                onTap: () {
                   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(obra: obra)),
    );
                },
              ));
        },
      ): Container(alignment: Alignment.center,child: Padding(padding: EdgeInsets.all(5),child: Text("Nenhuma Obra Encontrada", textAlign: TextAlign.center)),),
    );
  }
}
