import 'package:flutter/material.dart';
import 'package:todo_list/widgets/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Minha lista de tarefas"),
        ),
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}
