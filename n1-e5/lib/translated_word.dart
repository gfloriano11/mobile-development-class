import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslatedWord extends StatefulWidget {
  final String word;
  final String language;

  const TranslatedWord({super.key, required this.word, required this.language});

  @override
  State<TranslatedWord> createState() => _TranslatedWordState();
}

class _TranslatedWordState extends State<TranslatedWord> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak() async {
    await flutterTts.setLanguage(widget.language);
    await flutterTts.speak(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: speak,
          icon: const Icon(Icons.volume_up, color: Colors.black, size: 30),
        ),
        Text(widget.word, textScaler: const TextScaler.linear(1.2)),
      ],
    );
  }
}
