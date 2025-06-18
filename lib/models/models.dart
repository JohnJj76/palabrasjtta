// Models
class Libro {
  final String titulo;
  final String imagen;
  final List<Capitulo> capitulos;
  bool isPrefer;

  Libro({
    required this.titulo,
    required this.imagen,
    required this.capitulos,
    this.isPrefer = false,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    var chaptersJson = json['capitulos'] as List<dynamic>;
    List<Capitulo> chapterList =
        chaptersJson.map((c) => Capitulo.fromJson(c)).toList();
    return Libro(
      titulo: json['titulo'],
      imagen: json['imagen'],
      capitulos: chapterList,
    );
  }
}

class Capitulo {
  final int numero;
  final String titulo;
  final String contenido;
  final String negritas;

  bool isRead;
  bool isFavorite;

  Capitulo({
    required this.numero,
    required this.titulo,
    required this.contenido,
    required this.negritas,
    this.isRead = false,
    this.isFavorite = false,
  });

  factory Capitulo.fromJson(Map<String, dynamic> json) {
    return Capitulo(
      numero: json['numero'],
      titulo: json['titulo'],
      contenido: json['contenido'],
      negritas: json['negritas'],
    );
  }
}
