import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? imageFile;
  String imageUrl = '';

  // Função para atualizar o nome do usuário no Firebase Realtime Database
  Future<void> updateUserName(String newName) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users/${user.uid}');
        await userRef.update({'name': newName});
      }
    } catch (error) {
      print('Erro ao atualizar o nome do usuário: $error');
    }
  }

  // Função para recuperar o nome do usuário do Firebase Realtime Database
  Future<String> getUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users/${user.uid}');
        DatabaseEvent dbEvent = await userRef.once();
        Map<Object?, Object?> data = dbEvent.snapshot.value as Map<Object?, Object?>;

        return data.entries.first.value.toString(); // Retorna o nome do usuário, ou uma string vazia se não houver um nome
      }
      return ''; // Retorna uma string vazia se o usuário não estiver autenticado
    } catch (error) {
      print('Erro ao recuperar o nome do usuário: $error');
      return ''; // Retorna uma string vazia em caso de erro
    }
  }

  _openGallery(BuildContext context) async {
    try {
      var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picture != null) {
        setState(() {
          imageFile = picture;
        });
        Navigator.of(context).pop();
      }
    } catch (error) {
      print('Erro ao abrir a galeria: $error');
    }
  }

  _openCamera(BuildContext context) async {
    try {
      var picture = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picture != null) {
        setState(() {
          imageFile = picture;
        });
        Navigator.of(context).pop();
      }
    } catch (error) {
      print('Erro ao abrir a câmera: $error');
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Imagem"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Câmera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (error) {
      print('Erro ao exibir o diálogo de escolha: $error');
    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && imageFile != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
        UploadTask uploadTask = storageReference.putFile(File(imageFile!.path));
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        String downloadURL = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadURL;
        });
      }
    } catch (error) {
      print('Erro ao fazer upload da imagem para o Firebase Storage: $error');
    }
  }

  Widget _decideImageView(BuildContext context) {
    try {
      if (imageUrl.isNotEmpty) {
        return CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(imageUrl),
        );
      } else if (imageFile != null) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(File(imageFile!.path)),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _showChoiceDialog(context);
                },
              ),
            ),
          ],
        );
      } else {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
        ),
            Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _showChoiceDialog(context);
                },
              ),
            ),
          ],
        );
      }
    } catch (error) {
      print('Erro ao decidir a visualização da imagem: $error');
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[300],
      );
    }
  }

  void _signOut() async {
    try {
      _showSignOutConfirmation();
    } catch (error) {
      print('Erro ao efetuar logout: $error');
    }
  }

  void _showSignOutConfirmation() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sair da Conta'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Nosso tempo foi tão curto, deseja mesmo ir embora?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // Você pode adicionar aqui a navegação para a tela de login ou outra ação após o logout
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Erro ao exibir o diálogo de confirmação de logout: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _decideImageView(context),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 22),
                Row(children: [
                  FutureBuilder<String>(
                    future: getUserName(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erro ao carregar nome do usuário');
                      } else {
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    },
                  ),
                  SizedBox(width: 22),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit_outlined),
                  )
                ]),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(2, 20, 2, 15),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.mode_edit_rounded, color: Colors.black),
                    title: Text('Editar perfil'),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.sync_problem_rounded, color: Colors.black),
                    title: Text('Relatar problemas no app'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.post_add_rounded, color: Colors.black),
                    title: Text('Solicitar conteúdo'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.exit_to_app_rounded, color: Colors.black),
                    title: Text('Sair'),
                    onTap: () {
                      _signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
