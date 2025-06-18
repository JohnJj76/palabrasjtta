class Book {
  final String titulo;
  final String imagen;
  final List<Chapter> capitulos;
  bool isFavorito;

  Book({
    required this.titulo,
    required this.imagen,
    required this.capitulos,
    this.isFavorito = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var chaptersJson = json['capitulos'] as List<dynamic>;
    List<Chapter> chapterList =
        chaptersJson.map((c) => Chapter.fromJson(c)).toList();
    return Book(
      titulo: json['titulo'],
      imagen: json['imagen'],
      capitulos: chapterList,
    );
  }

  Map<String, dynamic> toMap() {
    return {'titulo': titulo, 'isFavorite': isFavorito};
  }
}

//
class Chapter {
  final int numero;
  final String titulo;
  final String contenido;
  final String negritas;

  bool isRead;
  bool isFavorite;

  Chapter({
    required this.numero,
    required this.titulo,
    required this.contenido,
    required this.negritas,
    this.isRead = false,
    this.isFavorite = false,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      numero: json['numero'],
      titulo: json['titulo'],
      contenido: json['contenido'],
      negritas: json['negritas'],
    );
  }
}
