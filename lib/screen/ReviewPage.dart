import 'package:flutter/material.dart';
import '../utils/content.dart';

class ReviewPage extends StatelessWidget {
  final Content content;

  ReviewPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: new Icon(Icons.arrow_back),
            alignment: Alignment.bottomLeft,
            padding: new EdgeInsets.all(5.0),
            onPressed: () {
              _navigate(context);
            },
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(content.image),
            radius: 50,
          ),
          SizedBox(height: 20),
          Text(
            content.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Gênero: ${content.genre}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implementar lógica para avaliar o conteúdo
            },
            child: Text('Avaliar'),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).pop();
  }
}
