import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yourop/screen/Pesquisa/SearchPage.dart';
import 'package:yourop/services/api_consumer.dart';
import 'page/description.dart';
import 'page/critic.dart';
import 'page/commentspage.dart';

class ReviewPage extends StatelessWidget {
  var teste = GlobalKey();
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
    double getHeight() {
      print(teste.currentContext);
      if (teste.currentContext != null) {
        RenderBox box = (teste.currentContext!.findRenderObject() as RenderBox);
        double h = box.size.height;
        return h;
      } else {
        return 280;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(obra['tituloObra']!,  style: TextStyle(
              color: Colors.black,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.search_sharp),
            onPressed: () {
              _navigateToSearchPage(context);
            },
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: ListView(
        children: [
          Padding(
            key: teste,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.network(
                  obra['imageURL']!,
                  height: 120,
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
                  indicatorColor: Color.fromARGB(255, 156, 144, 230),
                  labelColor: Color.fromARGB(255, 156, 144, 230),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Descrição'),
                    Tab(text: 'Meta Crítica'),
                    Tab(text: 'Avaliações'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - getHeight(),
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
