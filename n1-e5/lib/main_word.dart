import 'package:flutter/material.dart';

class MainWord extends StatefulWidget {
  final String text;
  const MainWord({super.key, required this.text});

  @override
  State<MainWord> createState() => _MainWord();
}

class _MainWord extends State<MainWord> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text, textScaler: TextScaler.linear(1.6));
  }
}
