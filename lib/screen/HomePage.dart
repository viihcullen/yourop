import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/content.dart';
import 'ReviewPage/ReviewPage.dart';
import 'SearchPage.dart';

class HomePage extends StatelessWidget {
  final List<Content> availableContents = [
    Content(
      title: 'Game A',
      genre: 'Ação',
      creator: 'jnjhgjhg',
      nationality: "",
      image:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    Content(
      title: 'Barbie',
      genre: 'Comédia',
      creator: 'njhbhgfhg',
      nationality: "",
      image:
          'https://i.pinimg.com/564x/e5/62/90/e56290a55446b17c9ad17cfa93a87300.jpg',
    ),
    Content(
      title: 'Euphoria',
      genre: 'Drama',
      creator: 'nsdfhjgjuhy',
      nationality: "",
      image:
          'https://i.pinimg.com/564x/ac/e4/ac/ace4ac67522fd1ddbe5a8770c88122bd.jpg',
    ),
  ];

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }

  void _navigateToReviewPage(BuildContext context, Content content) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(content: content)),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  pegarUsuario() async {
    final User? user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              child: Ink(
                decoration: const ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 2.0,
                    ),
                  ],
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  padding: const EdgeInsets.all(10.0),
                  onPressed: () {
                    _navigateToSearchPage(context);
                  },
                  iconSize: 30,
                ),
              ),
            ),
            Container(
              height: 150,
              child: Text(
                'Bem - Vindo .....',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Talvez você goste',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableContents.length,
                itemBuilder: (context, index) {
                  final content = availableContents[index];
                  return Container(
                    width: 150,
                    child: ListTile(
                      title: Text(content.title),
                      subtitle: Text(content.genre),
                      onTap: () {
                        _navigateToReviewPage(context, content);
                      },
                    ),
                  );
                },
              ),
            ),
            Text(
              'Talvez você goste',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableContents.length,
                itemBuilder: (context, index) {
                  final content = availableContents[index];
                  return Container(
                    width: 150,
                    child: ListTile(
                      title: Text(content.title),
                      subtitle: Text(content.genre),
                      onTap: () {
                        _navigateToReviewPage(context, content);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
