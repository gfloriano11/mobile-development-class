import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task.dart';

class Home extends StatefulWidget {
  final bool isAddingTask;
  const Home({super.key, required this.isAddingTask});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<String> tasks = ["Fazer TODO LIST Mobile"];
  final TextEditingController _controller = TextEditingController();

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
      _controller.value = TextEditingValue.empty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          if (widget.isAddingTask)
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
          Column(spacing: 3, children: [...tasks.map((t) => Task(content: t))]),
          // ListView.builder(
          //   itemBuilder: (ctx, index) {
          //     return Column(
          //       spacing: 3,
          //       children: [...tasks.map((t) => Task(content: t))],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
