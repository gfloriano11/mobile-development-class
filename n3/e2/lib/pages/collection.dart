import 'package:flutter/material.dart';
import 'package:flutter_e2/models/game.dart';
import 'package:flutter_e2/pages/game.dart';
import 'package:flutter_e2/services/game.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _Collection();
}

class _Collection extends State<Collection> {
  final _gameService = GameService();
  final _searchController = TextEditingController();

  List<Game> _games = [];

  bool _isLoading = true;
  bool _isAscending = true;

  String? _errorMessage;
  String? _selectedStatus;
  String? _selectedCategory;

  final List<String> _statuses = [
    'Quero jogar',
    'Jogando',
    'Concluído',
    'Abandonado',
  ];

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

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadGames() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final games = await _gameService.getAll();

      if (!mounted) return;

      setState(() {
        _games = games;
      });
    } catch (error) {
      debugPrint('error: $error');

      if (!mounted) return;

      setState(() {
        _errorMessage = 'Não foi possível carregar sua coleção.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Retorna os jogos conforme os filtros e a ordenação selecionados.
  List<Game> get _filteredGames {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = _games.where((game) {
      final matchesName = game.name.toLowerCase().contains(query);

      final matchesStatus =
          _selectedStatus == null || game.status == _selectedStatus;

      final matchesCategory =
          _selectedCategory == null || game.category == _selectedCategory;

      return matchesName && matchesStatus && matchesCategory;
    }).toList();

    filtered.sort((a, b) {
      final comparison = a.name.toLowerCase().compareTo(b.name.toLowerCase());

      return _isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  // Abre o formulário para cadastro ou edição.
  Future<void> _openForm({Game? game}) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => GameFormPage(game: game)),
    );

    if (result == true) {
      _loadGames();
    }
  }

  // Solicita confirmação antes de excluir um jogo.
  Future<void> _confirmDelete(Game game) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir jogo'),
          content: Text(
            'Deseja realmente excluir "${game.name}" da sua coleção?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await _gameService.delete(game.id!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jogo excluído com sucesso!')),
      );

      await _loadGames();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível excluir o jogo.')),
      );
    }
  }

  // Limpa todos os filtros e restaura a ordenação padrão.
  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = null;
      _selectedCategory = null;
      _isAscending = true;
    });
  }

  // Controles de pesquisa e filtragem.
  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Pesquisar jogo',
              hintText: 'Digite o nome...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  hint: const Text('Todas'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  hint: const Text('Todos'),
                  items: _statuses.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Text(
                '${_filteredGames.length} jogo(s)',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const Spacer(),

              TextButton.icon(
                onPressed: _isAscending
                    ? () => setState(() => _isAscending = false)
                    : () => setState(() => _isAscending = true),
                icon: Icon(
                  _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                ),
                label: Text(_isAscending ? 'Nome: A–Z' : 'Nome: Z–A'),
              ),

              IconButton(
                tooltip: 'Limpar filtros',
                onPressed: _clearFilters,
                icon: const Icon(Icons.filter_alt_off),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Constrói a lista de jogos filtrados.
  Widget _buildGameList() {
    final games = _filteredGames;

    if (games.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off, size: 48),
              SizedBox(height: 12),
              Text('Nenhum jogo encontrado.', style: TextStyle(fontSize: 18)),
              SizedBox(height: 4),
              Text('Tente alterar os filtros ou a pesquisa.'),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.sports_esports)),
            title: Text(game.name),
            subtitle: Text('${game.category} • ${game.status}'),
            onTap: () => _openForm(game: game),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _openForm(game: game);
                } else if (value == 'delete') {
                  _confirmDelete(game);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Editar'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text('Excluir'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Define o conteúdo conforme o estado da tela.
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_errorMessage!),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _loadGames,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_games.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videogame_asset_outlined, size: 56),
            SizedBox(height: 12),
            Text('Sua coleção está vazia.', style: TextStyle(fontSize: 18)),
            SizedBox(height: 4),
            Text('Adicione seu primeiro jogo!'),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildFilters(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadGames,
            child: _buildGameList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Coleção')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
