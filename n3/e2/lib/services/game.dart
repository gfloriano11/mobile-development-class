import 'package:flutter_e2/database/database.dart';

import '../models/game.dart';

class GameService {
  final AppDatabase _database = AppDatabase.instance;

  Future<List<Game>> getAll() async {
    final db = await _database.database;

    final result = await db.query('games', orderBy: 'name ASC');

    return result.map(Game.fromMap).toList();
  }

  Future<int> create(Game game) async {
    final db = await _database.database;

    return db.insert('games', game.toMap());
  }

  Future<int> update(Game game) async {
    final db = await _database.database;

    return db.update(
      'games',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _database.database;

    return db.delete('games', where: 'id = ?', whereArgs: [id]);
  }
}
