import 'package:flutter/material.dart';

class Transformations extends StatelessWidget {
  const Transformations({super.key});

  @override
  Widget build(BuildContext context) {
    final numbers = [1, 2, 3, 4, 5];

    final strings = numbers.map((number) => number.toString()).toList();

    final doubled = numbers.map((number) => number * 2).toList();

    final words = ["Flutter", "é", "incrível"];

    final names = ["Gustavo", "João", "Maria"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Transformações"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Números",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text("Original: $numbers"),
            Text("Strings: $strings"),
            Text("Multiplicados por 2: $doubled"),

            const SizedBox(height: 24),

            const Text(
              "Palavras",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            ...words.map((word) => Text(word)).toList(),

            const SizedBox(height: 24),

            const Text(
              "Nomes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...names.map(
                  (name) => ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text("Você pressionou $name"),
                        ),
                      );
                    },
                    child: Text(name),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
