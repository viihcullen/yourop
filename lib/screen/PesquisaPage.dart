import 'package:flutter/material.dart';
import '../model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<Model> main_list = [
    Model(
      "One Piece",
      1999,
      9.5,
      "https://i0.wp.com/animesbr.cc/wp-content/uploads/2022/03/eHm0zM4d0guGeybbc8vTGdTOCXw.jpg?resize=185%2C278&ssl=1",
    ),
  ];

  List<Model> display_list = List.from(main_list);

  void updateList(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.grey.shade700,
                suffixIcon: Icon(Icons.mic),
                suffixIconColor: Colors.grey.shade700,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  title: Text(
                    display_list[index].title!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${display_list[index].release_year!}',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  trailing: Text(
                    "${display_list[index].rating}",
                    style: TextStyle(color: Colors.deepPurple.shade200),
                  ),
                  leading: Image.network(
                    display_list[index].poster_url!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
