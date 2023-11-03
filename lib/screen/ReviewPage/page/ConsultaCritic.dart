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
      ),
      body: Column(
        children: [
          Text(metaR['tituloAvaliacaoCritica']),
          Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: metaR['_count']['criterioAvaliativo'],
                itemBuilder: (context, index) {
                  return 
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      children: [
                      Text(metaR['criterioAvaliativo'][index]['valorAvaliacaoCritica'].toString()),
                      Text(metaR['criterioAvaliativo'][index]['criterioAvaliativo']['nomeCriterioAvaliativo'])
                    ],
                  ));
                },
              )),
          Text(metaR['comentarioAvaliacaoCritica'])
        ],
      ),
    );
  }
}
