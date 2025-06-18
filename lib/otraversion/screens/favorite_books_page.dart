import 'package:flutter/material.dart';
import 'package:palabrasjtta/otraversion/models/book.dart';
import 'package:palabrasjtta/otraversion/screens/charters_list.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';

class FavoriteBooksPage extends StatelessWidget {
  void openBookChapters(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChartersList(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final favorites = bookProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Palabras Favoritas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              bookProvider.clearFavorites();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body:
          favorites.isEmpty
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
                itemCount: favorites.length,
                separatorBuilder: (_, __) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final book = favorites[index];
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
                              child: Image.asset(
                                //Image.network(
                                book.imagen,
                                width: 120,
                                height: 90,
                                fit: BoxFit.fill,
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
      //
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
