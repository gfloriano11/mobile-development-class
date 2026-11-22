import 'package:flutter_e2/database/database.dart';

import '../models/game.dart';

class GameService {
  final AppDatabase _database = AppDatabase.instance;

  // Consulta os jogos armazenados e converte os registros em objetos Game.
  Future<List<Game>> getAll() async {
    final db = await _database.database;

    final result = await db.query('games', orderBy: 'name ASC');

    return result.map(Game.fromMap).toList();
  }

  // Insere um novo jogo no banco de dados.
  Future<int> create(Game game) async {
    final db = await _database.database;

    return db.insert('games', game.toMap());
  }

  // Atualiza os dados de um jogo utilizando seu ID como referência.
  Future<int> update(Game game) async {
    final db = await _database.database;

    return db.update(
      'games',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }

  // Exclui o registro correspondente ao ID informado.
  Future<int> delete(int id) async {
    final db = await _database.database;

    return db.delete('games', where: 'id = ?', whereArgs: [id]);
  }
}
