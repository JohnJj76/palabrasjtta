import 'package:flutter/material.dart';
import 'package:palabrasjtta/models/models.dart';
import 'package:palabrasjtta/pages/capitulos_list.dart';

class LibrosFavoritos extends StatelessWidget {
  final List<Libro> favoriteBooks;

  const LibrosFavoritos({Key? key, required this.favoriteBooks})
    : super(key: key);

  void openBookChapters(BuildContext context, Libro book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CapitulosList(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Libros Favoritos'), centerTitle: true),
      body:
          favoriteBooks.isEmpty
              ? Center(
                child: Text(
                  'No tienes capítulos favoritos aún.',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
              )
              : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                itemCount: favoriteBooks.length,
                separatorBuilder: (_, __) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final book = favoriteBooks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => openBookChapters(context, book),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                book.imagen,
                                width: 100,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (_, __, ___) => Container(
                                      width: 100,
                                      height: 70,
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
                                  Text(
                                    '${book.capitulos.length} capítulo${book.capitulos.length != 1 ? "s" : ""}',
                                    style: TextStyle(
                                      color: Colors.deepPurple.shade400,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
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
              ),
    );
  }
}
