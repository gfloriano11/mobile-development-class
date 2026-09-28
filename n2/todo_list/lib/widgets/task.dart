import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
  bool checked = false;
  void onChange(bool? value) {
    setState(() {
      widget.task.done = value ?? false;
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
            widget.task.title,
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
