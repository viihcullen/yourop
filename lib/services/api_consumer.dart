import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = "youropapi-6dd8933b8ff5.herokuapp.com";

class API {
  static Future<http.Response> registerUser(Object body) async {
    var response = await http.post(Uri.https(baseUrl, "api/v1/usuario"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body));
    return response;
  }

  static Future<http.Response> getObras() async {
    var response = await http.get(Uri.https(baseUrl, "api/v1/obra"));
    return response;
  }

  static Future<String> getImageUrl(String name) async {
    final ref = FirebaseStorage.instance
        .refFromURL("gs://db-yourop.appspot.com/obra_images/$name.jpg");
    return await ref.getDownloadURL();
  }

  static Future<http.Response> cadastrarComentario(Object body) async {
    var response = await http.post(
        Uri.https(baseUrl, "api/v1/avaliacaousuario"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(body));
    return response;
  }

  static Future<http.Response> getObra(String id) async {
    var response = await http.get(Uri.https(baseUrl, "api/v1/obra/$id"));
    return response;
  }

  static Future<http.Response> getUsuario(String uid) async {
    var response = await http.get(Uri.https(baseUrl, "api/v1/usuario/$uid"));
    return response;
  }

  static Future<http.Response> setNomeUsuario(
      String uid, String newName) async {
    var response = await http.put(Uri.https(baseUrl, "api/v1/usuario"),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
        body: json.encode({'uidUsuario': uid, 'nomeUsuario': newName}));
    return response;
  }

  static Future<http.Response> getTipoObras() async {
    var response = await http.get(Uri.https(baseUrl, "api/v1/tipoobra"));
    return response;
  }

  static Future<http.Response> getCategorias() async {
    var response = await http.get(Uri.https(baseUrl, "api/v1/categoriaobra"));
    return response;
  }

  static Future<http.Response> searchFilter(
      List<String> categorias, List<String> tipoObras) async {
    var response = await http.post(Uri.https(baseUrl, "api/v1/obra/search"),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
        body: jsonEncode({'categorias': categorias, 'tipoObras': tipoObras}));

    return response;
  }

  static Future<http.Response> searchForTipoObra(List<String> tipoObras) async {
    var response = await http.post(Uri.https(baseUrl, "api/v1/obra/search"),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
        body: jsonEncode({'tipoObras': tipoObras}));

    return response;
  }

  static Future<http.Response> searchForCategoria(
      List<String> categorias) async {
    var response = await http.post(Uri.https(baseUrl, "api/v1/obra/search"),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
        body: jsonEncode({'categorias': categorias}));

    return response;
  }

  static Future<http.Response> searchForTerm(String termo) async{
    var response = await http.post(Uri.https(baseUrl, "api/v1/obra/search"),
    headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
        body: jsonEncode({'termo': termo}));
        return response;
  }
}
