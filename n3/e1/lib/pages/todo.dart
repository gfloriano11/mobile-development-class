import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/supabase.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  // READ
  Future<void> _loadTodos() async {
    try {
      final response = await supabase
          .from('todos')
          .select()
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        _todos = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (error) {
      _showMessage('Não foi possível carregar as tarefas.');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // CREATE / UPDATE
  Future<void> _showTodoDialog({Map<String, dynamic>? todo}) async {
    final titleController = TextEditingController(text: todo?['title'] ?? '');

    final descriptionController = TextEditingController(
      text: todo?['description'] ?? '',
    );

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(todo == null ? 'Nova tarefa' : 'Editar tarefa'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    hintText: 'O que você precisa fazer?',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe um título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Adicione detalhes (opcional)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, true);
                }
              },
              child: Text(todo == null ? 'Criar' : 'Salvar'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      try {
        final data = {
          'title': titleController.text.trim(),
          'description': descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
        };

        if (todo == null) {
          await supabase.from('todos').insert({
            ...data,
            'user_id': supabase.auth.currentUser!.id,
          });
        } else {
          await supabase.from('todos').update(data).eq('id', todo['id']);
        }

        await _loadTodos();
        _showMessage(
          todo == null ? 'Tarefa criada com sucesso!' : 'Tarefa atualizada!',
        );
      } catch (error) {
        _showMessage('Não foi possível salvar a tarefa.');
      }
    }

    titleController.dispose();
    descriptionController.dispose();
  }

  // UPDATE
  Future<void> _toggleTodo(Map<String, dynamic> todo) async {
    try {
      await supabase
          .from('todos')
          .update({'is_completed': !todo['is_completed']})
          .eq('id', todo['id']);

      await _loadTodos();
    } catch (error) {
      _showMessage('Não foi possível atualizar a tarefa.');
    }
  }

  // DELETE
  Future<void> _deleteTodo(String id) async {
    try {
      await supabase.from('todos').delete().eq('id', id);

      await _loadTodos();
      _showMessage('Tarefa excluída!');
    } catch (error) {
      _showMessage('Não foi possível excluir a tarefa.');
    }
  }

  Future<void> _logout() async {
    try {
      await supabase.auth.signOut();
    } catch (error) {
      _showMessage('Não foi possível sair da conta.');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _todos
        .where((todo) => todo['is_completed'] == true)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Lista',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF263449),
          ),
        ),
        backgroundColor: const Color(0xFFF7F9FC),
        actions: [
          IconButton(
            onPressed: _logout,
            tooltip: 'Sair',
            icon: const Icon(Icons.logout_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadTodos,
              child: _todos.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 140),
                        Icon(
                          Icons.check_circle_outline,
                          size: 64,
                          color: Color(0xFF789BCB),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nenhuma tarefa por aqui',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF263449),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Adicione sua primeira tarefa!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF8A96A6)),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        Text(
                          'Suas tarefas',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$completedCount de ${_todos.length} concluídas',
                          style: const TextStyle(color: Color(0xFF8A96A6)),
                        ),
                        const SizedBox(height: 20),
                        ..._todos.map((todo) {
                          final completed = todo['is_completed'] == true;

                          return Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: const BorderSide(color: Color(0xFFE3E8EF)),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              leading: Checkbox(
                                value: completed,
                                activeColor: const Color(0xFF789BCB),
                                onChanged: (_) => _toggleTodo(todo),
                              ),
                              title: Text(
                                todo['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  decoration: completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: completed
                                      ? Colors.grey
                                      : const Color(0xFF263449),
                                ),
                              ),
                              subtitle: todo['description'] != null
                                  ? Text(todo['description'])
                                  : null,
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showTodoDialog(todo: todo);
                                  } else if (value == 'delete') {
                                    _deleteTodo(todo['id']);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Editar'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Excluir'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(),
        backgroundColor: const Color(0xFF789BCB),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
