import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  bool _notificacoes = true;
  bool _modoCompacto = false;
  String _temaLista = 'Padrao';

  // TODO_ATIVIDADE_10
  // Retorne para a tela anterior um Map<String, bool> contendo as chaves
  // 'notificacoes' e 'modoCompacto'.
  void _salvar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('TODO 10: devolver configuracoes.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuracoes')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Notificacoes'),
              value: _notificacoes,
              onChanged: (valor) => setState(() => _notificacoes = valor),
            ),
            CheckboxListTile(
              title: const Text('Modo compacto'),
              value: _modoCompacto,
              onChanged: (valor) {
                setState(() => _modoCompacto = valor ?? false);
              },
            ),
            const Divider(),
            DropdownButtonFormField<String>(
              initialValue: _temaLista,
              decoration: const InputDecoration(
                labelText: 'Estilo visual da lista',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Padrao', child: Text('Padrao')),
                DropdownMenuItem(value: 'Compacto', child: Text('Compacto')),
                DropdownMenuItem(value: 'Confortavel', child: Text('Confortavel')),
              ],
              onChanged: (valor) {
                if (valor != null) {
                  setState(() => _temaLista = valor);
                }
              },
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.check),
              label: const Text('Salvar e voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
