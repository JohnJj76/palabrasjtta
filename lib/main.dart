import 'package:flutter/material.dart';
import 'package:palabrasjtta/otraversion/providers/book_provider.dart';
import 'package:palabrasjtta/otraversion/screens/book_list_page.dart';
import 'package:provider/provider.dart';

//void main() => runApp(LibrosApp());
void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => BookProvider(), child: LibrosApp()),
  );
}

class LibrosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palabras de Poder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: BookListPage(),
    );
  }
}
