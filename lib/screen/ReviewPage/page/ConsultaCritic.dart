import 'package:flutter/material.dart';

class ConsultaCritic extends StatelessWidget {
  final Map<String, dynamic> metaR;
  const ConsultaCritic({super.key, required this.metaR});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
            title: Text(metaR['tituloAvaliacaoCritica']),
      ),
      body: Column(
        children: [
          Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: metaR['_count']['criterioAvaliativo'],
                itemBuilder: (context, index) {
                  return 
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      children: [
                      Text(metaR['criterioAvaliativo'][index]['valorAvaliacaoCritica'].toString()),
                      Text(metaR['criterioAvaliativo'][index]['criterioAvaliativo']['nomeCriterioAvaliativo'])
                    ],
                  ));
                },
              )),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(metaR['comentarioAvaliacaoCritica'], textAlign: TextAlign.center),
              ),
              Container(
                 padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                child: Column(
                      children: [
                      Text(metaR['valorAvaliacaoCriticaGeral'].toString(), style: TextStyle(fontSize: 20),),
                      Text("Avaliação Geral")
                    ],
                  ),
              )
        ],
      ),
    );
  }
}
