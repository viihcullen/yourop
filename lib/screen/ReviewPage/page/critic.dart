import 'package:flutter/material.dart';
import 'package:yourop/screen/ReviewPage/page/ConsultaCritic.dart';
import '../../../models/content.dart';

class MetaReviewCritic extends StatelessWidget {
  final Map<String, dynamic> content;

  MetaReviewCritic({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final metaReviews =   content['avaliacaoCritica'];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [Expanded(child: ListView.builder(
            itemCount: metaReviews.length,
            itemBuilder: (context, index){
              final rev = metaReviews[index];
              return Card(child: ListTile(title: Text(rev['tituloAvaliacaoCritica']), trailing: Wrap(crossAxisAlignment: WrapCrossAlignment.center ,children: [Text(rev['valorAvaliacaoCriticaGeral'].toString()), const Icon(Icons.star)],), onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ConsultaCritic(metaR: rev,);
              }));
            }),);
            }))]
          /*(metaReviews.length > 0) ? metaReviews.map((metaR){
            return Card(child: ListTile(title: Text(metaR['tituloAvaliacaoCritica']), trailing: Wrap(crossAxisAlignment: WrapCrossAlignment.center ,children: [Text(metaR['valorAvaliacaoCriticaGeral'].toString()), const Icon(Icons.star)],), onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ConsultaCritic(metaR: metaR,);
              }));
            }),);
          }).toList():[const Text("Sem meta review")],*/
        ),
      ),
    );
  }
}
