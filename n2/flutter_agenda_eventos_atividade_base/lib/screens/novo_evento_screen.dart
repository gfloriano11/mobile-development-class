import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../utils/categorias.dart';

class NovoEventoScreen extends StatefulWidget {
  const NovoEventoScreen({super.key});

  @override
  State<NovoEventoScreen> createState() => _NovoEventoScreenState();
}

class _NovoEventoScreenState extends State<NovoEventoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _localController = TextEditingController();
  final _descricaoController = TextEditingController();

  String _categoria = 'Tecnologia';
  bool _inscrito = false;
  bool _salvando = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _localController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  // TODO_ATIVIDADE_09
  // 1) valide o Form;
  // 2) marque _salvando=true com setState();
  // 3) aguarde 600 ms;
  // 4) crie um Evento com os dados dos controllers;
  // 5) devolva o objeto com Navigator.pop(context, evento).
  Future<void> _salvar() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('TODO 09: implementar cadastro.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriasCadastro = categorias.where((c) => c != 'Todos').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo evento')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (_salvando) const LinearProgressIndicator(),
              if (_salvando) const SizedBox(height: 16),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o titulo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(
                  labelText: 'Local',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o local.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                items: categoriasCadastro
                    .map(
                      (categoria) => DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      ),
                    )
                    .toList(),
                onChanged: _salvando
                    ? null
                    : (valor) {
                        if (valor != null) {
                          setState(() => _categoria = valor);
                        }
                      },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descricaoController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Descricao',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Ja quero me inscrever'),
                value: _inscrito,
                onChanged: _salvando
                    ? null
                    : (valor) => setState(() => _inscrito = valor),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _salvando ? null : _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
