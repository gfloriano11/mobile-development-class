import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../utils/categorias.dart';

class DetalhesEventoScreen extends StatefulWidget {
  const DetalhesEventoScreen({
    super.key,
    required this.evento,
  });

  final Evento evento;

  @override
  State<DetalhesEventoScreen> createState() => _DetalhesEventoScreenState();
}

class _DetalhesEventoScreenState extends State<DetalhesEventoScreen> {
  // TODO_ATIVIDADE_07
  // Use showDialog<bool>. Se o usuario confirmar, volte para a Home com
  // Navigator.pop(context, true). Cancelar deve fechar apenas o dialogo.
  Future<void> _confirmarExclusao() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('TODO 07: implementar exclusao.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final evento = widget.evento;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            tooltip: 'Excluir',
            onPressed: _confirmarExclusao,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(
                        iconeDaCategoria(evento.categoria),
                        size: 64,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Chip(label: Text(evento.categoria)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              evento.titulo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Local: ${evento.local}'),
            const SizedBox(height: 16),
            Text(evento.descricao),
            const SizedBox(height: 24),
            // TODO_ATIVIDADE_08
            // Faça o botao alternar evento.inscrito com setState().
            // O texto do botao deve mudar conforme o estado.
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('TODO 08: alterar inscricao.')),
                );
              },
              icon: const Icon(Icons.how_to_reg),
              label: const Text('TODO 08'),
            ),
          ],
        ),
      ),
    );
  }
}
