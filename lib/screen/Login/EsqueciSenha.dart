import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EsqueciSenha extends StatefulWidget {
  const EsqueciSenha({super.key});

  @override
  State<EsqueciSenha> createState() => _EsqueciSenhaState();
}

class _EsqueciSenhaState extends State<EsqueciSenha> {
  bool _isProcessing = false;
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.deepOrange.shade300,
                ),
              ),
            ),
          ),
          _isProcessing
              ? CircularProgressIndicator()
              : Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isProcessing = true;
                          });
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: emailController.text)
                              .then((value) {
                                Navigator.of(context).pop();
                              })
                              .catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Um erro aconteceu ao recuperar a senha")));
                          });
                        },
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
