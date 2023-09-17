import 'package:flutter/material.dart';
import '../../utils/content.dart';

class ReviewPage extends StatelessWidget {
  final Content content;

  ReviewPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.search_sharp),
                onPressed: () {
                  _openSearch(context);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(content.image),
                radius: 50,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
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
                    ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TabBarView(children: [
                    Container(
                      child: Text("sdsdd"),
                    ),
                    Container(
                      child: Text("dg"),
                    ),
                    Container(
                      child: Text("ererw"),
                    ),
                  ]),
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
