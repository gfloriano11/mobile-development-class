import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<String> tasks = ["Fazer TODO LIST Mobile"];
  final TextEditingController _controller = TextEditingController();
  bool isAddingTask = false;

  void createTask(String title) {
    if (title.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite uma tarefa antes de adicionar."),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }
    setState(() {
      tasks.add(title);
      _controller.clear();
      isAddingTask = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          FilledButton(
            child: Text(isAddingTask ? "Fechar" : "Adicionar"),
            onPressed: () => setState(() => isAddingTask = !isAddingTask),
          ),

          if (isAddingTask)
            Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 800),
                  child: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Digite uma tarefa",
                    ),
                    controller: _controller,
                    onSubmitted: (text) => createTask(text),
                  ),
                ),
              ],
            ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Task(content: tasks[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
