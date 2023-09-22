import 'package:flutter/material.dart';
import '../../models/User.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'https://example.com/user_profile_image.jpg', // URL da imagem do perfil
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nome de Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Descrição do usuário aqui...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de edição do perfil
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Teste(),
  ));
}
