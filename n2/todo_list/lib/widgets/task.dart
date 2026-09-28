import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String content;
  const Task({super.key, required this.content});

  @override
  State<Task> createState() => _Task();
}

class _Task extends State<Task> {
  bool checked = false;
  void onChange(bool? value) {
    setState(() {
      checked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 800),
        child: Row(
          children: [
            Checkbox(
              onChanged: (bool? changed) => onChange(changed),
              value: checked,
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) return Colors.green;
                return Colors.white;
              }),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              padding: EdgeInsetsGeometry.all(16),
              child: Text(
                widget.content,
                style: TextStyle(
                  decoration: checked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
