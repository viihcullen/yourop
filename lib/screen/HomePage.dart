import 'package:flutter/material.dart';
import '../utils/content.dart';
import 'ReviewPage.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Content> availableContents = [
    Content(
      title: 'Game A',
      genre: 'Ação',
      image:
          'https://i.pinimg.com/564x/d5/5b/6c/d55b6c725a66bd51dde099652c95cda4.jpg',
    ),
    Content(
      title: 'Barbie',
      genre: 'Comédia',
      image:
          'https://i.pinimg.com/564x/e5/62/90/e56290a55446b17c9ad17cfa93a87300.jpg',
    ),
    Content(
      title: 'Euphoria',
      genre: 'Drama',
      image:
          'https://i.pinimg.com/564x/ac/e4/ac/ace4ac67522fd1ddbe5a8770c88122bd.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.search),
            alignment: Alignment.bottomRight,
            onPressed: () {
              _navigate(context);
            },
          ),
          Container(
              height: 150,
              child: Text(
                'Bem - Vindo .....',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Text(
            'Talvez você goste',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              height: 500,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewPage(content: content),
                          ),
                        );
                      },
                    ),
                  );
                },
              ))
        ],
      ),
    ));
  }

  void _navigate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPage()));
  }
}
