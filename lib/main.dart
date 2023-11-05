import 'package:flutter/material.dart';
import 'package:yourop/screen/Login/LoginPage.dart';

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
        primaryColor: Colors.deepPurple[300],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors
              .white, // Cor da barra de aplicativos (branco) // Cor dos ícones (preto)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
      ),
      home: LoginPage(),
    );
  }
}
