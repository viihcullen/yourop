import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yourop/screen/ReviewPage/ReviewPage.dart';
import 'package:yourop/services/api_consumer.dart';
import '../../../models/content.dart';

Future<String> _loadImageFromFirebaseStorage(String uid) async {
    if (uid != null) {
      String downloadURL = "";
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$uid');
          try{
      downloadURL = await storageReference.getDownloadURL();
          }catch(e){

          }
      print(downloadURL);
      return downloadURL;
    }
    return '';
  }

class CommentsPage extends StatefulWidget {
  final Map<String, dynamic> content;

  CommentsPage({required this.content});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  double ratingComment = 0.0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.content['avaliacaoUsuario'].length,
                itemBuilder: (context, index) {
                  final comment = widget.content['avaliacaoUsuario'][index];
                  return CommentItem(comment: comment);
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.purple,
                      ),
                        onRatingUpdate: (rating) {
                          print("Avaliação atualizada para $rating");
                          ratingComment = rating;
                        },
                        )
                      ],
                    ),
                    Row(
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
                          onPressed: () async {
                            var idUsuario = json.decode((await API.getUsuario(
                                    FirebaseAuth.instance.currentUser!.uid))
                                .body)['idUsuario'];
                            var response = await API.cadastrarComentario({
                              'idObra': widget.content['idObra'],
                              'idUsuario': idUsuario,
                              'valorAvaliacao': ratingComment,
                              'comentarioAvaliacao': _commentController.text
                            });
                            if (response.statusCode == 200) {
                              _commentController.text = "";
                              var newObra = json.decode(
                                  (await API.getObra(widget.content['idObra']))
                                      .body);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReviewPage(obra: newObra)));
                            }
                            /* // Adicione seu código de envio de comentários aqui
                    final newComment = Comment(
                      username: 'User',
                      text: _commentController.text,
                    );
                    widget.content.comments.add(newComment);
                    _commentController.clear();
                    // Você também pode chamar setState() para atualizar a lista de comentários */
                          },
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
    );
  }
}

class CommentItem extends StatefulWidget {
  Map<String, dynamic> comment;
  String imageURL = "";
  CommentItem({super.key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  void loadImageUsuario() async {
    var teste = await _loadImageFromFirebaseStorage(widget.comment['usuario']['userUIDAuth']);
   setState(() {
      widget.imageURL = teste;
   });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImageUsuario();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
                    leading: CircleAvatar(
                        backgroundImage: widget.imageURL.isNotEmpty?NetworkImage(widget.imageURL):null,
                        ),
                    title: Text(widget.comment['usuario']['nomeUsuario']),
                    subtitle: Text(widget.comment['comentarioAvaliacao']),
                  );
  }
}