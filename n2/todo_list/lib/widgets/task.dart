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
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) return Colors.green;
            return Colors.white;
          }),
          checkColor: Colors.white,
          value: checked,
          onChanged: (value) {
            setState(() {
              checked = value ?? false;
            });
          },
          title: Text(
            widget.content,
            style: TextStyle(
              color: checked ? Colors.grey : Colors.black,
              decoration: checked
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
