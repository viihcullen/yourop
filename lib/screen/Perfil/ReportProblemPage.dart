import 'package:flutter/material.dart';

class ReportProblemPage extends StatefulWidget {
  const ReportProblemPage({Key? key}) : super(key: key);

  @override
  _ReportProblemPageState createState() => _ReportProblemPageState();
}

class _ReportProblemPageState extends State<ReportProblemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      // Simule o envio do relatório (substitua por sua lógica real)
      // Pode ser feito aqui, por exemplo, um envio para um servidor.
      // Após o envio, você pode exibir um SnackBar com feedback.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Relatório enviado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatar problema'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), // Ícone de volta em preto
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            color:
                Theme.of(context).primaryColor, // Ícone de envio personalizado
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
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O título é obrigatório.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A descrição é obrigatória.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _submitReport,
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
