class Obra {
  final String? idObra;
  final String? tituloObra;
  final String? resumoObra;
  final String? idDiretor;
  String? imageUrl;
  final String? idEscritor;

  Obra(
      {this.idObra,
      this.tituloObra,
      this.resumoObra,
      this.idDiretor,
      this.idEscritor});
}

class Escritor {
  final String? idEscritor;
  final String? nomeEscritor;
  Escritor({this.idEscritor, this.nomeEscritor});
}

class Categoria {
  final String? idCategoria;
  final String? nomeCategoria;
  Categoria({this.idCategoria, this.nomeCategoria});
}

class ObraCategoria {
  final String? idObraCategoria;
  final String? idObra;
  final String? idCategoria;
  final List<Categoria> obraCategoria;
  ObraCategoria(
      {this.idObraCategoria,
      this.idObra,
      this.idCategoria,
      this.obraCategoria = const []});
}
