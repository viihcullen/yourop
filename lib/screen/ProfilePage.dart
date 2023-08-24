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
    Navigator.pop(context);
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
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://example.com/user_profile_image.jpg', // URL da imagem do perfil
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            _isEditing
                ? ElevatedButton(
                    onPressed: _saveChanges,
                    child: Text('Salvar Alterações'),
                  )
                : ElevatedButton(
                    onPressed: _startEditing,
                    child: Text('Editar Perfil'),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SairPage();
              },
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

  void SairPage() {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            child: SizedBox(
              width: 300,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Nosso tempo foi tão curto, deseja mesmo ir embora?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 171,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: const [
                                  Text('Sim',
                                      style: TextStyle(color: Colors.black))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          ElevatedButton(
                            onPressed: () => null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: const [
                                  Text('Não',
                                      style: TextStyle(color: Colors.black))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
