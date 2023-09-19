import 'package:flutter/material.dart';
import '../../../models/content.dart';

class BetaReviewCritic extends StatelessWidget {
  final Content content;

  BetaReviewCritic({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final betaReview = content.betaReview;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: betaReview != null
            ? Text(betaReview)
            : Text('Nenhuma crítica beta disponível.'),
      ),
    );
  }
}
