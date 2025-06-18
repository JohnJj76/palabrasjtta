import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palabrasjtta/models/models.dart';
import 'package:palabrasjtta/pages/libros_favoritos.dart';
import 'capitulos_list.dart';

class LibrosList extends StatefulWidget {
  @override
  _LibrosListState createState() => _LibrosListState();
}

class _LibrosListState extends State<LibrosList> {
  late Future<List<Libro>> booksFuture;
  List<Libro> _books = [];

  @override
  void initState() {
    super.initState();
    booksFuture = loadBooks();
    booksFuture.then((value) {
      setState(() {
        _books = value;
      });
    });
  }

  Future<List<Libro>> loadBooks() async {
    final jsonStr = await rootBundle.loadString('assets/predicas.json');
    List<dynamic> jsonList = json.decode(jsonStr);
    List<Libro> loadedBooks =
        jsonList.map((json) => Libro.fromJson(json)).toList();
    return loadedBooks;
  }

  void openBookChapters(Libro book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => CapitulosList(
              book: book,
              onFavoriteChanged: _onChapterFavoriteChanged,
            ),
      ),
    );
  }

  void _onChapterFavoriteChanged() {
    // Update state to reflect changes in favorites of chapters for books
    setState(() {});
  }

  void openFavoriteBooks() {
    final favoriteBooks =
        _books
            .where(
              (book) => book.capitulos.any((chapter) => chapter.isFavorite),
            )
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LibrosFavoritos(favoriteBooks: favoriteBooks),
      ),
    );
  }

  void toggleFavorite(int index) {
    setState(() {
      _books[index].isPrefer = !_books[index].isPrefer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palabras de Poder'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            tooltip: 'Libros Favoritos',
            onPressed: openFavoriteBooks,
          ),
        ],
      ),
      body: FutureBuilder<List<Libro>>(
        future: booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error cargando los libros'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay libros disponibles'));
          }

          final books = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: books.length,
            separatorBuilder: (_, __) => SizedBox(height: 16),
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => openBookChapters(book),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            //Image.network(
                            book.imagen,
                            width: 120,
                            height: 90,
                            fit: BoxFit.fill,
                            errorBuilder:
                                (_, __, ___) => Container(
                                  width: 120,
                                  height: 90,
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    color: Colors.grey.shade600,
                                    size: 40,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.titulo,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade700,
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '${book.capitulos.length} capítulo${book.capitulos.length != 1 ? "s" : ""}',
                                    style: TextStyle(
                                      color: Colors.deepPurple.shade400,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  IconButton(
                                    icon: Icon(
                                      book.isPrefer
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          book.isPrefer ? Colors.green : null,
                                    ),
                                    onPressed: () => toggleFavorite(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: Colors.deepPurple.shade300,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 30,
        color: Colors.grey[400],
        padding: const EdgeInsets.all(2),
        child: const Text(
          '© 2025 John Barrios Marzola',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
