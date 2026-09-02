import 'package:flutter/material.dart';
import 'package:word_translate/app.dart';
import 'package:word_translate/translated_word.dart';

class Translations extends StatelessWidget {
  final List<WordTranslation> translations;
  const Translations({super.key, required this.translations});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 6,
      children: translations
          .map((t) => TranslatedWord(word: t.word, language: t.language))
          .toList(),
    );
  }
}
