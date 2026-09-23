import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Task(content: "Oii")
        ],
      ),
    );
  }
}