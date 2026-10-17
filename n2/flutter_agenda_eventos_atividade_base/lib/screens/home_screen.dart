import 'package:flutter/material.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/detalhes_evento_screen.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/entrada_screen.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/novo_evento_screen.dart';

import '../data/eventos_iniciais.dart';
import '../models/evento.dart';
import '../widgets/cabecalho_agenda.dart';
import '../widgets/evento_card.dart';
import 'ciclo_vida_screen.dart';
import 'configuracoes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.nomeUsuario,
  });

  final String nomeUsuario;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _buscaController = TextEditingController();
  late final List<Evento> _eventos;
  late final List<String> categorias;

  String _categoria = 'Todos';
  bool _somenteInscritos = false;

  @override
  void initState() {
    super.initState();
    _eventos = criarEventosIniciais();
    categorias = criarCategorias();
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  // TODO_ATIVIDADE_01 (FEITO)
  // Filtre por texto, categoria e opcionalmente por eventos em que o usuario
  // esta inscrito. Consulte o enunciado antes de implementar.
  List<Evento> get _eventosFiltrados {
    final value = _buscaController.value.text.trim().toLowerCase();
    final cleanedCategory = _categoria.toLowerCase().trim();

    return _eventos.where((e) {
      final searchConditional = value.isEmpty ||
          e.titulo.toLowerCase().contains(value) ||
          e.descricao.toLowerCase().contains(value) ||
          (value.isNotEmpty && e.categoria.toLowerCase().contains(value));

      final categoryConditional = cleanedCategory == "todos" ||
          e.categoria.toLowerCase().contains(cleanedCategory);

      final subscribedConditional = !_somenteInscritos || e.inscrito;

      return searchConditional && subscribedConditional && categoryConditional;
    }).toList();
  }

  // TODO_ATIVIDADE_02 (FEITO)
  // Abra DetalhesEventoScreen usando Navigator.push e aguarde um bool.
  // Se voltar true, remova o evento da lista. Caso contrario, atualize a tela.
  Future<void> _abrirDetalhes(Evento evento) async {
    final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                DetalhesEventoScreen(evento: evento)));

    if (result == true) {
      setState(() {
        _eventos.removeWhere((e) => e.id == evento.id);
      });
    } else {
      setState(() {});
    }
  }

  // TODO_ATIVIDADE_03 (FEITO)
  // Abra NovoEventoScreen e aguarde um Evento. Se vier um resultado,
  // adicione-o a lista usando setState() e mostre um SnackBar.
  Future<void> _adicionarEvento() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NovoEventoScreen()));

    if (!mounted) return;

    if (result != null) {
      setState(() {
        _eventos.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feito')),
      );
    }
  }

  Future<void> _abrirConfiguracoes() async {
    final resultado = await Navigator.push<Map<String, bool>>(
      context,
      MaterialPageRoute<Map<String, bool>>(
        builder: (_) => const ConfiguracoesScreen(),
      ),
    );

    if (!mounted || resultado == null) return;

    final notificacoes = resultado['notificacoes'] ?? false;
    final modoCompacto = resultado['modoCompacto'] ?? false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Configuracoes: notificacoes=$notificacoes, compacto=$modoCompacto',
        ),
      ),
    );
  }

  void changeCategory(String category) {
    setState(() {
      if (_categoria == category) {
        _categoria = "Todos";
        return;
      }
      _categoria = category;
    });
  }

  void toggleSubscription(Evento e) {
    setState(() {
      e.inscrito = !e.inscrito;
    });
  }

  // TODO_ATIVIDADE_04 (FEITO)
  // Exiba um AlertDialog de confirmacao e, se o usuario confirmar,
  // retorne a EntradaScreen limpando a pilha de rotas com pushAndRemoveUntil.
  Future<void> _sair() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Você realmente deseja sair?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => EntradaScreen()),
                ModalRoute.withName("/")),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtrados = _eventosFiltrados;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          IconButton(
            tooltip: 'Ciclo de vida',
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const CicloVidaScreen(),
                ),
              );
            },
            icon: const Icon(Icons.sync),
          ),
          IconButton(
            tooltip: 'Configuracoes',
            onPressed: _abrirConfiguracoes,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: _sair,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _adicionarEvento,
        icon: const Icon(Icons.add),
        label: const Text('Novo evento'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CabecalhoAgenda(
                nomeUsuario: widget.nomeUsuario,
                total: _eventos.length,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _buscaController,
                decoration: const InputDecoration(
                  labelText: 'Buscar por titulo ou local',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  // TODO_ATIVIDADE_05 (FEITO)
                  // Use Iterable.map() para transformar cada String da lista
                  // categorias em um FilterChip e finalize com toList().
                  children: [
                    ...categorias.map((c) => FilterChip(
                          label: Text(c),
                          onSelected: (bool value) => changeCategory(c),
                          selected: _categoria == c,
                        ))
                  ],
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mostrar somente minhas inscricoes'),
                value: _somenteInscritos,
                onChanged: (valor) {
                  setState(() => _somenteInscritos = valor);
                },
              ),
              const Divider(),
              Expanded(
                child: filtrados.isEmpty
                    ? const Center(child: Text('Nenhum evento encontrado.'))
                    : ListView.builder(
                        itemCount: filtrados.length,
                        itemBuilder: (context, index) {
                          final evento = filtrados[index];
                          return EventoCard(
                            evento: evento,
                            onTap: () => _abrirDetalhes(evento),
                            // TODO_ATIVIDADE_06 (FEITO)
                            // Inverta evento.inscrito dentro de setState().
                            onInscricao: () => toggleSubscription(evento),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
