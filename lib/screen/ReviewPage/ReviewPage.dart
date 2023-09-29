import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/content.dart';
import 'page/description.dart';
import 'page/critic.dart';
import 'page/commentspage.dart';

class ReviewPage extends StatelessWidget {
  final Content content;

  ReviewPage({required this.content});

  // Função para calcular a média das avaliações
  double calculateAverageRating(List<double> ratings) {
    if (ratings.isEmpty) {
      return 0.0; // Retorna 0 se não houver avaliações
    }

    double totalRating = 0.0;

    for (var rating in ratings) {
      totalRating += rating;
    }

    return totalRating / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageRatingUser = calculateAverageRating(content.userRatings);
    double averageRatingMeta = calculateAverageRating(content.metaRatings);

    return Scaffold(
      appBar: AppBar(
        title: Text(content.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search_sharp),
            onPressed: () {
              _openSearch(context);
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
                CircleAvatar(
                  backgroundImage: NetworkImage(content.imageUrl),
                  radius: 50,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nacionalidade: ${content.nationality}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Criadores: ${content.creator}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Gênero: ${content.genre}',
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
                          color: Colors.purple,
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
                          color: Colors.purple,
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
                        content: content,
                      ),
                      MetaReviewCritic(
                        content: content,
                      ),
                      CommentsPage(
                        content: content,
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

  void _openSearch(BuildContext context) {}
}
