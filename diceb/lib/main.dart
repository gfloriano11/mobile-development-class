import 'package:flutter/material.dart';

import 'package:diceb/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 5, 38, 109),
          Color.fromARGB(255, 21, 81, 149),
        ),
      ),
    ),
  );
}
