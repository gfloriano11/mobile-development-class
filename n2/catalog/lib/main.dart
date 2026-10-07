import 'package:catalog/models/product.dart';
import 'package:catalog/screens/lifecycle_history.dart';
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
    price: 67.0,
    quantity: 9,
  ),
  Product(
    description: "Samsung com windows 11. 500GB e 16GB de RAM.",
    name: "Notebook",
    price: 61.67,
    quantity: 26,
  ),
  Product(
    description: "Samsung S24 256GB e 8GB de RAM",
    name: "Celular",
    price: 42,
    quantity: 15,
  ),
  Product(
    description: "Console PlayStation 5. Spider-Man incluso.",
    name: "PS5",
    price: 67000.99,
    quantity: 120,
  ),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;

  final List<AppLifecycleState> history = [];

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onStateChange: (state) {
        debugPrint('Novo estado: $state');

        setState(() {
          history.add(state);
        });
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Catalog",
      home: Catalog(
        history: history,
      ),
    );
  }
}

class Catalog extends StatefulWidget {
  final List<AppLifecycleState> history;

  const Catalog({
    super.key,
    required this.history,
  });

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const CatalogPage(),
      const Transformations(),
      LifecycleHistory(
        history: widget.history,
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.transform_outlined),
            selectedIcon: Icon(Icons.transform),
            label: 'Transformações',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }
}

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: list[index],
          );
        },
      ),
    );
  }
}
