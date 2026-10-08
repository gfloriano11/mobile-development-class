import 'package:catalog/models/product.dart';
import 'package:catalog/widgets/product_card.dart';
import 'package:flutter/material.dart';

class Catalog extends StatelessWidget {
  const Catalog({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> list = [
      Product(
        description: "Televisão 42pol. Full HD.",
        name: "Televisão",
        price: 4500.99,
        quantity: 30,
      ),
      Product(
        description: "Samsung com windows 11. 500GB e 16GB de RAM.",
        name: "Notebook",
        price: 2699.99,
        quantity: 26,
      ),
      Product(
        description: "Samsung S24 256GB e 8GB de RAM",
        name: "Celular",
        price: 2999.99,
        quantity: 15,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ProductCard(product: list[index]);
        },
      ),
    );
  }
}
