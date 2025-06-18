import 'package:flutter/material.dart';
import 'package:palabrasjtta/models/models.dart';

class CapituloDatalle extends StatefulWidget {
  final Capitulo chapter;
  const CapituloDatalle({Key? key, required this.chapter}) : super(key: key);

  @override
  State<CapituloDatalle> createState() => _CapituloDatalleState();
}

class _CapituloDatalleState extends State<CapituloDatalle> {
  List<String> misNegras = [];
  @override
  void initState() {
    super.initState();
    palameo(widget.chapter);
  }

  palameo(Capitulo chapter) {
    List<String> palabras = chapter.negritas.split(RegExp(r'-'));
    for (String palab in palabras) {
      misNegras.add(palab);
      print(palab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chapter.titulo), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          child: Expanded(
            //
            child: TextoResaltado(
              texto: widget.chapter.contenido,
              palabrasNegrita: misNegras,
              //palabrasNegrita: ["El resentimiento", "Puede"],
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
              fontSize: 22,
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
    String textoRestante = texto;

    while (textoRestante.isNotEmpty) {
      // Buscar la primera coincidencia de cualquier palabra en negrita
      int indiceMin = textoRestante.length;
      String? palabraEncontrada;

      for (var palabra in palabrasNegrita) {
        final index = textoRestante.toLowerCase().indexOf(
          palabra.toLowerCase(),
        );
        if (index != -1 && index < indiceMin) {
          indiceMin = index;
          palabraEncontrada = palabra;
        }
      }

      if (palabraEncontrada == null) {
        // No se encontró más, agregar el resto normal
        spans.add(TextSpan(text: textoRestante));
        break;
      }

      // Agregar texto antes de la palabra encontrada
      if (indiceMin > 0) {
        spans.add(TextSpan(text: textoRestante.substring(0, indiceMin)));
      }

      // Agregar palabra en negrita
      spans.add(
        TextSpan(
          text: textoRestante.substring(
            indiceMin,
            indiceMin + palabraEncontrada.length,
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      );

      // Cortar texto procesado
      textoRestante = textoRestante.substring(
        indiceMin + palabraEncontrada.length,
      );
    }

    return spans;
  }
}
