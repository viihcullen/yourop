import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  String? _photoUrl;

  @override
  void initState() {
    super.initState();

    // Verificar se o usuário está conectado
    final user = _auth.currentUser;
    if (user != null) {
      // Obter as informações do usuário do Firebase
      setState(() {
        _name = user.displayName;
        _email = user.email;
        _photoUrl = user.photoURL;
      });
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Foto',
                ),
                initialValue: _photoUrl,
                readOnly: true,
              ),
              ElevatedButton(
                onPressed: () {
                  // Verificar se o usuário está conectado
                  final user = _auth.currentUser;
                  if (user != null) {
                    _formKey.currentState!
                        .save(); // Chame o onSaved para atualizar o valor do _name.

                    // Verificar se o campo 'nome' tem um valor não vazio
                    if (_name != null && _name!.isNotEmpty) {
                      // Atualizar as informações do usuário no Firebase
                      user.updateProfile(displayName: _name).then((_) {
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
