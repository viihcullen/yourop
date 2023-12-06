import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yourop/services/api_consumer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();

    // Verificar se o usuário está conectado
    final user = _auth.currentUser;
    if (user != null) {
      // Obter as informações do usuário do Firebase
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');
      userRef.once().then(
        (value) {
          setState(() {
            Map<Object?, Object?> data =
                value.snapshot.value as Map<Object?, Object?>;
            _name = data.entries.first.value.toString();
            _email = user.email;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                initialValue: _email,
                readOnly: true,
              ),
              ElevatedButton(
                onPressed: () {
                  // Verificar se o usuário está conectado
                  final user = _auth.currentUser;
                  DatabaseReference userRef = FirebaseDatabase.instance
                      .ref()
                      .child('users/${user?.uid}');
                  if (user != null) {
                    _formKey.currentState!
                        .save(); // Chame o onSaved para atualizar o valor do _name.

                    // Verificar se o campo 'nome' tem um valor não vazio
                    if (_name != null && _name!.isNotEmpty && _email != null && _email!.isNotEmpty) {
                      // Atualizar as informações do usuário no Firebase
                      userRef.update({'name': _name}).then((value) {
                        API.setNomeUsuario(user.uid, _name!);
                        user.updateDisplayName(_name);
                        user.updateEmail(_email!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Perfil atualizado com sucesso!'),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao atualizar o perfil: $error'),
                          ),
                        );
                      });
                    }
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
