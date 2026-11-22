import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  // Inicializa o banco somente quando ele for solicitado pela primeira vez.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Obtém o diretório de armazenamento local do aplicativo.
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_collection.db');

    // Abre o banco e cria a tabela caso ele ainda não exista.
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Define a estrutura dos registros de jogos armazenados.
        await db.execute('''
          CREATE TABLE games (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            description TEXT NOT NULL,
            status TEXT NOT NULL
          )
        ''');
      },
    );
  }
}
