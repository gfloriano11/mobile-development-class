import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_translate/main_word.dart';
import 'package:word_translate/translations.dart';

Future<Map<String, dynamic>> loadWords() async {
  final jsonString = await rootBundle.loadString('assets/words.json');
  return jsonDecode(jsonString);
}

class WordTranslation {
  final String word;
  final String language;

  WordTranslation({required this.word, required this.language});
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Map<String, dynamic> words = {};
  var currentIndex = 0;
  var mainLanguage = "pt-br";
  var mainLanguageWords = [];
  final List<WordTranslation> currentWordTranslations = [];

  void seeTranslations(int index) {
    if (currentWordTranslations.isNotEmpty) clearCurrentWords();
    words.forEach((key, value) {
      if (key != mainLanguage) {
        var currentLanguageWordsList = words[key].values.toList();
        setState(
          () => currentWordTranslations.add(
            WordTranslation(
              word: currentLanguageWordsList[currentIndex].toString(),
              language: key,
            ),
          ),
        );
      }
    });
  }

  void nextWord() {
    setState(() {
      if (currentIndex >= mainLanguageWords.length - 1) {
        currentIndex = 0;
      } else {
        currentIndex++;
      }
      clearCurrentWords();
    });
  }

  void previousWord() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = mainLanguageWords.length - 1;
      }
      clearCurrentWords();
    });
  }

  void clearCurrentWords() {
    setState(() => currentWordTranslations.clear());
  }

  @override
  void initState() {
    super.initState();
    loadWords().then((data) {
      setState(() {
        words = data;
        mainLanguageWords = data[mainLanguage].values.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.red, child: Text("Casa"));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (mainLanguageWords.isNotEmpty)
          MainWord(text: mainLanguageWords[currentIndex] ?? ""),
        TextButton(
          onPressed: () => seeTranslations(currentIndex),
          child: Text("Ver tradução"),
        ),
        if (currentWordTranslations.isNotEmpty)
          Translations(translations: currentWordTranslations),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: previousWord,
              child: Text("Palavra anterior"),
            ),
            TextButton(onPressed: nextWord, child: Text("Próxima palavra")),
          ],
        ),
      ],
    );
  }
}
