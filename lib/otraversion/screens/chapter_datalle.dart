import 'package:flutter/material.dart';
import 'package:palabrasjtta/otraversion/models/book.dart';

class ChapterDatalle extends StatefulWidget {
  final Chapter chapter;
  const ChapterDatalle({Key? key, required this.chapter}) : super(key: key);

  @override
  State<ChapterDatalle> createState() => _ChapterDatalleState();
}

class _ChapterDatalleState extends State<ChapterDatalle> {
  List<String> misNegras = [];
  List<String> misDeColor = [];

  @override
  void initState() {
    super.initState();
    octenerNegristas(widget.chapter);
  }

  octenerNegristas(Chapter chapter) {
    List<String> palabras = chapter.negritas.split(RegExp(r'-'));
    for (String palab in palabras) {
      misNegras.add(palab);
      print(palab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chapter.titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.purple,
          ),
        ),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          child: Expanded(
            child: TextoResaltado(
              texto: widget.chapter.contenido,
              palabrasNegrita: misNegras,
            ),
          ),
        ),
      ),
    );
  }
}

//
//
class TextoResaltado extends StatelessWidget {
  final String texto;
  final List<String> palabrasNegrita;

  const TextoResaltado({
    super.key,
    required this.texto,
    required this.palabrasNegrita,
  });

  @override
  Widget build(BuildContext context) {
    final spans = _getTextSpans(texto, palabrasNegrita);
    return Padding(
      padding: const EdgeInsets.all(6),
      child: SingleChildScrollView(
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              height: 1.2,
            ),
            children: spans,
          ),
        ),
      ),
    );
  }

  List<TextSpan> _getTextSpans(String texto, List<String> palabrasNegrita) {
    final List<TextSpan> spans = [];
    String textoTotal = texto;

    // solo para las negritas
    while (textoTotal.isNotEmpty) {
      // Buscar la primera coincidencia de cualquier palabra en negrita
      int indiceMin = textoTotal.length;
      String? palabraEncontrada;
      bool resttin = false;

      // palabras negritas o moradas
      for (var palabra in palabrasNegrita) {
        //
        final index = textoTotal.toLowerCase().indexOf(palabra.toLowerCase());

        if (index != -1 && index < indiceMin) {
          indiceMin = index;
          palabraEncontrada = palabra;
        }
      }

      if (palabraEncontrada == null) {
        // No se encontró más, agregar el resto normal
        spans.add(TextSpan(text: textoTotal));
        break;
      }

      // Agregar texto antes de la palabra encontrada
      if (indiceMin > 0) {
        spans.add(TextSpan(text: textoTotal.substring(0, indiceMin)));
      }

      if (palabraEncontrada.substring(0, 1) == "⋅") {
        resttin = true;
      } else {
        resttin = false;
      }

      // Agregar palabra en negrita
      spans.add(
        resttin
            ? TextSpan(
              text: textoTotal.substring(
                indiceMin,
                indiceMin + palabraEncontrada.length,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            )
            : TextSpan(
              text: textoTotal.substring(
                indiceMin,
                indiceMin + palabraEncontrada.length,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
      );

      // Cortar texto procesado
      textoTotal = textoTotal.substring(indiceMin + palabraEncontrada.length);
    }

    return spans;
  }
}
