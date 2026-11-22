import 'package:flutter/material.dart';
import 'package:flutter_e2/models/game.dart';
import 'package:flutter_e2/services/game.dart';

class GameFormPage extends StatefulWidget {
  final Game? game;

  const GameFormPage({super.key, this.game});

  @override
  State<GameFormPage> createState() => _GameFormPageState();
}

class _GameFormPageState extends State<GameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _gameService = GameService();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _categories = [
    'RPG',
    'Ação',
    'Aventura',
    'FPS',
    'Indie',
    'Estratégia',
    'Terror',
    'Outros',
  ];

  final List<String> _statuses = [
    'Quero jogar',
    'Jogando',
    'Concluído',
    'Abandonado',
  ];

  String? _selectedCategory;
  String? _selectedStatus;

  bool _isSaving = false;

  bool get _isEditing => widget.game != null;

  @override
  void initState() {
    super.initState();

    // Preenche os campos quando um jogo existente é recebido.
    if (_isEditing) {
      final game = widget.game!;

      _nameController.text = game.name;
      _descriptionController.text = game.description;
      _selectedCategory = game.category;
      _selectedStatus = game.status;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  // Valida e executa a operação de cadastro ou atualização.
  Future<void> _saveGame() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final game = Game(
      id: widget.game?.id,
      name: _nameController.text.trim(),
      category: _selectedCategory!,
      description: _descriptionController.text.trim(),
      status: _selectedStatus!,
    );

    try {
      if (_isEditing) {
        await _gameService.update(game);
      } else {
        await _gameService.create(game);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Jogo atualizado com sucesso!'
                : 'Jogo cadastrado com sucesso!',
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível salvar o jogo.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar jogo' : 'Adicionar jogo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do jogo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do jogo.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma categoria.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: _statuses.map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um status.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              FilledButton(
                onPressed: _isSaving ? null : _saveGame,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isEditing ? 'Salvar alterações' : 'Cadastrar jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
