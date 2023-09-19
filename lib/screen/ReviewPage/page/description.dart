import 'package:flutter/material.dart';
import '../../../models/content.dart';

class Description extends StatelessWidget {
  final Content content;

  Description({required this.content, Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content.description,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
