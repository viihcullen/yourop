import 'package:flutter/material.dart';
import '../../../models/content.dart';

class CommentsPage extends StatefulWidget {
  final Content content;

  CommentsPage({required this.content});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.content.comments.length,
              itemBuilder: (context, index) {
                final comment = widget.content.comments[index];
                return ListTile(
                  leading: CircleAvatar(
                      // Exiba a foto do usuário aqui (comment.userPhotoUrl)
                      ),
                  title: Text(comment.username),
                  subtitle: Text(comment.text),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Digite seu comentário',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um comentário.';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Adicione seu código de envio de comentários aqui
                    final newComment = Comment(
                      username: 'User',
                      text: _commentController.text,
                    );
                    widget.content.comments.add(newComment);
                    _commentController.clear();
                    // Você também pode chamar setState() para atualizar a lista de comentários
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
