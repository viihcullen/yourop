import 'package:flutter/material.dart';
import 'package:yourop/screen/Login/Cadastrar/ValidarEmail/LoginPage.dart';

void main() => runApp(YourOpApp());

class YourOpApp extends StatelessWidget {
  const YourOpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YourOp - Review de Conteúdo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
      ),
      home: LoginPage(),
    );
  }
}
