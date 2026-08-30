import 'package:flutter/material.dart';

class Translations extends StatelessWidget {
  final List<String> translations;
  const Translations({super.key, required this.translations});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 6,
      children: translations
          .map((word) => Text(word, textScaler: TextScaler.linear(1.2)))
          .toList(),
    );
  }
}
