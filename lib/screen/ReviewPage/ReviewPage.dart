import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yourop/screen/Pesquisa/SearchPage.dart';
import '../../models/content.dart';
import 'page/description.dart';
import 'page/critic.dart';
import 'page/commentspage.dart';

class ReviewPage extends StatelessWidget {
  final Map<String, dynamic> obra;
  ReviewPage({required this.obra});

  // Função para calcular a média das avaliações
  double calculateAverageRating(double ratings) {
    return ratings;
  }

  @override
  Widget build(BuildContext context) {
    double averageRatingUser = calculateAverageRating(2.0);
    double averageRatingMeta = calculateAverageRating(4.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(obra['tituloObra']!),
        actions: [
          IconButton(
            icon: Icon(Icons.search_sharp),
            onPressed: () {
              _navigateToSearchPage(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.network(
                  obra['imageURL']!,
<<<<<<< Updated upstream
                  width: 100,
                  height: 50,
=======
                  height: 120,
>>>>>>> Stashed changes
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        obra['escritor'] != null
                            ? "Escritor: ${obra['escritor']['nomeEscritor']}"
                            : "Diretor: ${obra['diretor']['nomeDiretor']}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Gênero: ${obra['obraCategoria'].map((obracat) => obracat['categoria']['nomeCategoria']).join(', ')}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text("Critica de Usuarios"),
                      RatingBar.builder(
                        initialRating: averageRatingUser,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24.0,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.deepPurple[300],
                        ),
                        onRatingUpdate: (rating) {
                          print("Avaliação atualizada para $rating");
                        },
                      ),
                      Text("Critica Meta"),
                      RatingBar.builder(
                        initialRating: averageRatingMeta,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24.0,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.deepPurple[300],
                        ),
                        onRatingUpdate: (rating) {
                          print("Avaliação atualizada para $rating");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: Color.fromARGB(255, 156, 144, 230),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Descrição'),
                    Tab(text: 'Meta Crítica'),
                    Tab(text: 'Avaliações'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TabBarView(
                    children: [
                      Description(
                        content: obra,
                      ),
                      MetaReviewCritic(
                        content: obra,
                      ),
                      CommentsPage(
                        content: obra,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }
}
