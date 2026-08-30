import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_translate/main_word.dart';
import 'package:word_translate/translations.dart';

Future<Map<String, dynamic>> loadWords() async {
  final jsonString = await rootBundle.loadString('assets/words.json');
  return jsonDecode(jsonString);
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
  final List<String> currentWordTranslations = [];

  void seeTranslations(int index) {
    words.forEach((key, value) {
      if (key != mainLanguage) {
        var currentLanguageWordsList = words[key].values.toList();
        setState(
          () => currentWordTranslations.add(
            currentLanguageWordsList[currentIndex].toString(),
          ),
        );
      }
    });
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
        MainWord(text: mainLanguageWords[currentIndex] ?? ""),
        TextButton(
          onPressed: () => seeTranslations(currentIndex),
          child: Text("Ver tradução"),
        ),
        if (currentWordTranslations.isNotEmpty)
          Translations(translations: currentWordTranslations),
        Row(
          children: [
            TextButton(
              onPressed: () => seeTranslations(currentIndex),
              child: Text("prox."),
            ),
            TextButton(
              onPressed: () => seeTranslations(currentIndex),
              child: Text("anterior"),
            ),
          ],
        ),
      ],
    );
  }
}
