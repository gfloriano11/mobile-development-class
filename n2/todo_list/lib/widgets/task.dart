import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String content;
  const Task({super.key, required this.content});

  @override
  State<Task> createState() => _Task();
}

class _Task extends State<Task> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800
        ),
        child: Row(
        children: [
          Container(
            padding: EdgeInsetsGeometry.all(10),
            color: Colors.red,
            child: Text(widget.content),
          )
        ],
      ),
      ),
    );
  }
}