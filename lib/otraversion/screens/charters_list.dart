import 'package:flutter/material.dart';
import 'package:palabrasjtta/otraversion/models/book.dart';
import 'package:palabrasjtta/otraversion/screens/chapter_datalle.dart';

class ChartersList extends StatefulWidget {
  final Book book;
  final VoidCallback? onFavoriteChanged;

  ChartersList({Key? key, required this.book, this.onFavoriteChanged})
    : super(key: key);

  @override
  _ChartersListState createState() => _ChartersListState();
}

class _ChartersListState extends State<ChartersList> {
  late List<Chapter> chapters;

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

  void openChapterContent(Chapter chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChapterDatalle(chapter: chapter)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book.titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
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
                fontSize: 22,
                decoration: chapter.isRead ? TextDecoration.lineThrough : null,
                color: chapter.isRead ? Colors.red : Colors.black87,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    chapter.isRead
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: chapter.isRead ? Colors.red : Colors.grey,
                    size: 26,
                  ),
                  tooltip:
                      chapter.isRead
                          ? 'Marcar como no leído'
                          : 'Marcar como leído',
                  onPressed: () => toggleRead(index),
                ),
              ],
            ),
            onTap: () => openChapterContent(chapter),
          );
        },
      ),
    );
  }
}
