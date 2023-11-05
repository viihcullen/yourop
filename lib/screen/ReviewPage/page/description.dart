import 'package:flutter/material.dart';
import '../../../models/content.dart';

class Description extends StatelessWidget {
  final Map<String, dynamic> content;

  Description({required this.content, Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content['resumoObra'],
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
