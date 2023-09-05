import 'package:flutter/material.dart';

class Content {
  final String title;
  final String authorsOrProducers;
  final int releaseYear;
  final String image;
  final String category;
  final String description;

  Content({
    required this.title,
    required this.authorsOrProducers,
    required this.releaseYear,
    required this.image,
    required this.category,
    required this.description,
  });
}

class ContentRegistrationScreen extends StatefulWidget {
  @override
  _ContentRegistrationScreenState createState() =>
      _ContentRegistrationScreenState();
}

class _ContentRegistrationScreenState extends State<ContentRegistrationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorsOrProducersController =
      TextEditingController();
  final TextEditingController _releaseYearController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  String _selectedCategory = ''; // Categoria selecionada no menu suspenso
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> categories = [
    'Ação',
    'Aventura',
    'Comédia',
    'Drama',
    'Ficção Científica',
    'Terror',
    // Adicione outras categorias conforme necessário
  ];

  void _clearFields() {
    _titleController.clear();
    _authorsOrProducersController.clear();
    _releaseYearController.clear();
    _imageController.clear();
    _selectedCategory = '';
    _descriptionController.clear();
  }

  void _registerContent() {
    final String title = _titleController.text;
    final String authorsOrProducers = _authorsOrProducersController.text;
    final int releaseYear = int.tryParse(_releaseYearController.text) ?? 0;
    final String image = _imageController.text;
    final String description = _descriptionController.text;

    if (title.isNotEmpty &&
        authorsOrProducers.isNotEmpty &&
        releaseYear > 0 &&
        image.isNotEmpty &&
        _selectedCategory.isNotEmpty &&
        description.isNotEmpty) {
      // Execute a ação de registro aqui, por exemplo, adicionar à lista de conteúdos.
      Content newContent = Content(
        title: title,
        authorsOrProducers: authorsOrProducers,
        releaseYear: releaseYear,
        image: image,
        category: _selectedCategory,
        description: description,
      );
      // Após o registro, você pode adicionar o novo conteúdo a uma lista ou armazená-lo em algum lugar.
      print('Novo conteúdo registrado: $newContent');

      // Limpar os campos após o registro.
      _clearFields();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos Incompletos'),
            content: Text('Por favor, preencha todos os campos corretamente.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Conteúdo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _authorsOrProducersController,
              decoration: InputDecoration(labelText: 'Autores/Produtores'),
            ),
            TextField(
              controller: _releaseYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ano de Lançamento'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue ?? '';
                });
              },
              decoration: InputDecoration(labelText: 'Categoria'),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerContent,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContentRegistrationScreen(),
  ));
}
