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

  void _signOut() {
    _showSignOutConfirmation();
  }

  void _showSignOutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sair da Conta'),
          content: Text('Nosso tempo foi tão curto, deseja mesmo ir embora?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(); // Fechar o diálogo e a tela de perfil
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  children: [
                    Text('Sim', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  children: [
                    Text('Não', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://example.com/user_profile_image.jpg', // URL da imagem do perfil
              ),
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
