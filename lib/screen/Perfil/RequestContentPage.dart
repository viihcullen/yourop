import 'package:flutter/material.dart';

class RequestContentPage extends StatefulWidget {
  const RequestContentPage({Key? key}) : super(key: key);

  @override
  _RequestContentPageState createState() => _RequestContentPageState();
}

class _RequestContentPageState extends State<RequestContentPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      // Simular envio da solicitação para o servidor (substitua com a lógica real)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Solicitação enviada com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar conteúdo'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título Descritivo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O título é obrigatório.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: contentTypeController,
                decoration: InputDecoration(
                  labelText: 'Tipo de Conteúdo (ex: Livro, Filme)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O tipo de conteúdo é obrigatório.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Descrição Detalhada',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A descrição é obrigatória.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRequest,
                child: Text('Enviar Solicitação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
