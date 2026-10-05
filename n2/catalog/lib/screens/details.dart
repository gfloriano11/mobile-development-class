import 'package:catalog/models/product.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Product product;

  const Details({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detalhes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text(product.description),

            const SizedBox(height: 16),

            Text("Preço: R\$ ${product.price.toStringAsFixed(2)}"),

            const SizedBox(height: 8),

            Text("Quantidade disponível: ${product.quantity}"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Voltar ao catálogo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
