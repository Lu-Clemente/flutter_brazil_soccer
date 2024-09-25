import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:flutter_brazil_soccer/models/club.dart';
import 'package:flutter_brazil_soccer/repositories/clubs_repository.dart';

class DB {
  static Database? _database;
  static final DB instance = DB._();
  DB._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static get() async {
    return await DB.instance.database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'brazil_soccer_data.db'),
      onCreate: (db, version) async {
        await db.execute(clubs);
        await db.execute(championships);
        await setupClubs(db);
      },
      version: 1,
    );
  }

  String get clubs => '''
    CREATE TABLE clubs(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      points INTEGER,
      shield TEXT,
      color TEXT
    );
  ''';

  String get championships => '''
    CREATE TABLE championships(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      competition TEXT,
      year INTEGER,
      club_id INTEGER,
      FOREIGN KEY(club_id) REFERENCES clubs(id) ON DELETE CASCADE
    );
  ''';

  Future<void> setupClubs(Database db) async {
    final batch = db.batch();
    ClubsRepository.setupClubs().forEach((club) {
      batch.insert('clubs', {
        'name': club.name,
        'points': club.points,
        'shield': club.shield,
        'color': club.color.value.toRadixString(16),
      });
    });
    await batch.commit(noResult: true);
  }
}
