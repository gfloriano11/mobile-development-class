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
  bool isAddingTask = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Minha lista de tarefas")),
        body: Center(child: Home(isAddingTask: isAddingTask)),
        // floatingActionButton: FloatingActionButton(
        //   foregroundColor: Colors.black,
        //   onPressed: () => setState(() {
        //     isAddingTask = !isAddingTask;
        //   }),
        //   backgroundColor: Colors.green,
        //   child: isAddingTask ? const Icon(Icons.close) : const Icon(Icons.add),
        // ),
      ),
    );
  }
}
