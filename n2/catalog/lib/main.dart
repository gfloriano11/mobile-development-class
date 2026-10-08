import 'package:catalog/screens/catalog.dart';
import 'package:catalog/screens/lifecycle_history.dart';
import 'package:catalog/screens/transformations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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
      home: App(history: history),
    );
  }
}

class App extends StatefulWidget {
  final List<AppLifecycleState> history;

  const App({super.key, required this.history});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Catalog(),
      const Transformations(),
      LifecycleHistory(history: widget.history),
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
