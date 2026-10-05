import 'package:catalog/models/product.dart';
import 'package:catalog/screens/transformations.dart';
import 'package:catalog/widgets/product_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<Product> list = [
  Product(
    description: "Televisão 42pol. Full HD.",
    name: "Televisão",
    price: 1.0,
    quantity: 1,
  ),
  Product(
    description: "Samsung com windows 11. 500GB e 16GB de RAM.",
    name: "Notebook",
    price: 1,
    quantity: 1,
  ),
  Product(
    description: "Samsung S24 256GB e 8GB de RAM",
    name: "Celular",
    price: 1,
    quantity: 1,
  ),
  Product(
    description: "Console PlayStation 5. Spider-Man incluso.",
    name: "PS5",
    price: 1,
    quantity: 1,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void onPressed(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Transformations()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Catalog", home: Catalog());
  }
}

class Catalog extends StatelessWidget {
  const Catalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Transformations(),
                ),
              );
            },
            child: const Text('Ver transformações'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ProductCard(product: list[index]);
        },
      ),
    );
  }
}
