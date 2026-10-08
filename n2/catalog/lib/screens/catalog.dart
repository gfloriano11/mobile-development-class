import 'package:catalog/main.dart';
import 'package:catalog/widgets/product_card.dart';
import 'package:flutter/material.dart';

class Catalog extends StatelessWidget {
  const Catalog({super.key});

  @override
  Widget build(BuildContext context) {
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
