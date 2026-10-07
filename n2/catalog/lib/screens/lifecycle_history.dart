import 'package:flutter/material.dart';

class LifecycleHistory extends StatelessWidget {
  final List<AppLifecycleState> history;

  const LifecycleHistory({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: history.isEmpty
        ? 
        const Center(
            child: Text('Nenhum estado registrado ainda.'),
          )
        : ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(
                  history[index].name,
                ),
              );
            },
          ),
    );
  }
}