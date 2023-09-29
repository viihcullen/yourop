import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
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
              )));
        });
  }

  Widget _decideImageView(BuildContext context) {
    if (imageFile == null) {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[300],
      );
    } else {
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
    }
  }

  void _signOut() async {
    _showSignOutConfirmation();
  }

  void _showSignOutConfirmation() {
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
              onPressed: () {
                _signOut();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
    
       ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.black,
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
                Text(
                  'Luiza',
                  style: TextStyle(color: Colors.white),
                ),
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
                  ),
                  ListTile(
                    leading: Icon(Icons.post_add_rounded, color: Colors.black),
                    title: Text('Solicitar conteúdo'),
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
