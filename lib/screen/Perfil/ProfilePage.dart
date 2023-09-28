import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
      _usernameController.text = 'Nome de Usuário';
    });
  }

  void _saveChanges() {
    String newUsername = _usernameController.text;

    setState(() {
      _isEditing = false;
    });

    _showSaveDialog(newUsername);
  }

  void _showSaveDialog(String newUsername) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Perfil Atualizado'),
          content:
              Text('Seu nome de usuário foi atualizado para $newUsername.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
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
        title: Text('Perfil '),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
            ),
            const SizedBox(height: 20),
            _isEditing
                ? TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Nome de Usuário',
                    ),
                  )
                : Text(
                    'Nome de Usuário',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 20),
            _isEditing
                ? ElevatedButton(
                    onPressed: _saveChanges,
                    child: Text('Salvar Alterações'),
                  )
                : ElevatedButton(
                    onPressed: _startEditing,
                    child: Text('Editar Perfil'),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Sair da Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
