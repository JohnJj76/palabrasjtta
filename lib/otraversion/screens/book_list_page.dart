import 'package:flutter/material.dart';
import 'package:palabrasjtta/otraversion/models/book.dart';
import 'package:palabrasjtta/otraversion/screens/charters_list.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import 'favorite_books_page.dart';

class BookListPage extends StatefulWidget {
  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  @override
  void initState() {
    super.initState();
  }

  void openBookChapters(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ChartersList(
              book: book,
              //onFavoriteChanged: _onChapterFavoriteChanged,
              onFavoriteChanged: () {},
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Palabras de Poder'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteBooksPage()),
              );
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (context, index) {
          final book = bookProvider.books[index];
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
                                  book.isFavorito
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: book.isFavorito ? Colors.green : null,
                                  size: 24,
                                ),
                                onPressed: () {
                                  bookProvider.toggleFavorite(book);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
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
