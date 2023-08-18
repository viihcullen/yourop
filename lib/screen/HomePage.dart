import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  static String tag = 'HomePage';

  @override
  Widget build(BuildContext context) {
   
    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Bem -Vindo ${name.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[welcome],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
