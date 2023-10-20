import 'package:flutter/material.dart';
import 'package:yourop/screen/ReviewPage/page/ConsultaCritic.dart';
import '../../../models/content.dart';

class MetaReviewCritic extends StatelessWidget {
  final Content content;

  MetaReviewCritic({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final metaReviews = content.metaReviews;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: metaReviews.map((metaR){
            return Card(child: ListTile(title: Text(metaR.titulo), trailing: Wrap(crossAxisAlignment: WrapCrossAlignment.center ,children: [Text(metaR.valorAvaliacaoGeral.toString()), const Icon(Icons.star)],), onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ConsultaCritic(metaR: metaR,);
              }));
            }),);
          }).toList(),
        ),
      ),
    );
  }
}
