import 'package:flutter/material.dart';
import 'package:palabrasjtta/models/models.dart';
import 'package:palabrasjtta/pages/capitulo_datalle.dart';
//import 'mi_models.dart' show Book, Chapter;

class CapitulosList extends StatefulWidget {
  final Libro book;
  final VoidCallback? onFavoriteChanged;

  CapitulosList({Key? key, required this.book, this.onFavoriteChanged})
    : super(key: key);

  @override
  _CapitulosListState createState() => _CapitulosListState();
}

class _CapitulosListState extends State<CapitulosList> {
  late List<Capitulo> chapters;

  @override
  void initState() {
    super.initState();
    chapters = widget.book.capitulos;
  }

  void toggleRead(int index) {
    setState(() {
      chapters[index].isRead = !chapters[index].isRead;
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      chapters[index].isFavorite = !chapters[index].isFavorite;
    });
    if (widget.onFavoriteChanged != null) {
      widget.onFavoriteChanged!();
    }
  }

  void openChapterContent(Capitulo chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CapituloDatalle(chapter: chapter)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.titulo),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            tooltip: 'Libros Favoritos',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        itemCount: chapters.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            tileColor: chapter.isRead ? Colors.deepPurple.shade50 : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              chapter.titulo,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                decoration: chapter.isRead ? TextDecoration.lineThrough : null,
                color: chapter.isRead ? Colors.deepPurple : Colors.black87,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    chapter.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: chapter.isFavorite ? Colors.red : Colors.grey,
                  ),
                  tooltip:
                      chapter.isFavorite
                          ? 'Quitar de favoritos'
                          : 'Agregar a favoritos',
                  onPressed: () => toggleFavorite(index),
                ),
                IconButton(
                  icon: Icon(
                    chapter.isRead
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: chapter.isRead ? Colors.deepPurple : Colors.grey,
                  ),
                  tooltip:
                      chapter.isRead
                          ? 'Marcar como no leído'
                          : 'Marcar como leído',
                  onPressed: () => toggleRead(index),
                ),
              ],
            ),
            //onTap: () => openChapterContent(chapter),
            onTap: () {
              List<String> palabras = chapter.contenido.split(RegExp(r' '));
              for (String palab in palabras) {
                print(palab);
              }
              //openChapterContent(chapter);
              openChapterContent(chapter);
            },
          );
        },
      ),
    );
  }
}
