import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<http.Response> registerUser(Object body) async {
    var response = await http.post(
        Uri.https("youropapi-6dd8933b8ff5.herokuapp.com", "api/v1/usuario"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body));
    return response;
  }

  static Future<http.Response> getObras() async {
    var response = await http.get(Uri.https("youropapi-6dd8933b8ff5.herokuapp.com", "api/v1/obra"));
    return response;
  }

  static Future<String> getImageUrl(String name) async{
    final ref = FirebaseStorage.instance.refFromURL("gs://db-yourop.appspot.com/obra_images/$name.jpg");
    return await ref.getDownloadURL();
  }
}
