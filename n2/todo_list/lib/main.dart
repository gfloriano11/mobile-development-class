import 'package:flutter/material.dart';
import 'package:todo_list/widgets/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Minha lista de tarefas")),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Center(child: Home()),
          ),
        ),
      ),
    );
  }
}
