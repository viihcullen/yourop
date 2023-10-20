import 'package:flutter/material.dart';
import 'package:yourop/models/content.dart';

class ConsultaCritic extends StatelessWidget {
  final MetaReview metaR;
  const ConsultaCritic({super.key, required this.metaR});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(metaR.titulo),
        Text(metaR.comentarioAvaliativo)
      ],
    );
  }
}