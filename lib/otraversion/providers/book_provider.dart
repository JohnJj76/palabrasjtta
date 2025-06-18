import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para rootBundle
import 'package:shared_preferences/shared_preferences.dart';

import '../models/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;
  List<Book> get favorites => _books.where((book) => book.isFavorito).toList();

  BookProvider() {
    loadBooks();
  }

  Future<void> loadBooks() async {
    final String jsonString = await rootBundle.loadString('assets/books.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    _books = jsonData.map((json) => Book.fromJson(json)).toList();
    await loadFavorites();
    notifyListeners();
  }

  void toggleFavorite(Book book) {
    book.isFavorito = !book.isFavorito;
    saveFavorites();
    notifyListeners();
  }

  void clearFavorites() {
    for (var book in _books) {
      book.isFavorito = false;
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles = prefs.getStringList('favorites') ?? [];

    for (var book in _books) {
      book.isFavorito = favoriteTitles.contains(book.titulo);
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles =
        _books
            .where((book) => book.isFavorito)
            .map((book) => book.titulo)
            .toList();
    await prefs.setStringList('favorites', favoriteTitles);
  }
}
