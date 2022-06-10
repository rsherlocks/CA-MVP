import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  DatabaseRepository.privateConstructor();

  static final DatabaseRepository instance =
      DatabaseRepository.privateConstructor();

  final _databaseName = 'databaseCmv';
  final _databaseVersion = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
    }
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: await onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE player (
            playerId INTEGER PRIMARY KEY AUTOINCREMENT,
            playerName STRING NOT NULL,
            FK_player_category STRING NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE team (
            teamId INTEGER PRIMARY KEY AUTOINCREMENT,
            teamName STRING NOT NULL,
            playerIdOne INTEGER NOT NULL,
            playerIdTwo INTEGER NOT NULL,
            playerIdThree INTEGER NOT NULL,
            playerIdFour INTEGER NOT NULL,
            playerIdFive INTEGER NOT NULL,
            playerIdSix INTEGER NOT NULL,
            playerIdSeven INTEGER NOT NULL,
            playerIdEight INTEGER NOT NULL,
            FOREIGN KEY (playerIdOne) REFERENCES player (playerId),
            FOREIGN KEY (playerIdTwo) REFERENCES player (playerId),
            FOREIGN KEY (playerIdFour) REFERENCES player (playerId),
            FOREIGN KEY (playerIdFive) REFERENCES player (playerId)
          )
          ''');

    await db.execute('''
          CREATE TABLE match (
            matchId INTEGER PRIMARY KEY AUTOINCREMENT,
            matchName STRING NOT NULL,
            teamIdOne INTEGER NOT NULL,
            teamIdTwo INTEGER NOT NULL,
            scoreId INTEGER NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE score (
            scoreId INTEGER PRIMARY KEY AUTOINCREMENT,
            matchId INTEGER NOT NULL,
            overSerial INTEGER NOT NULL,
            deliverBalls STRING NOT NULL,
            FOREIGN KEY (matchId) REFERENCES score (matchId),

          )
          ''');

    await db.execute('''
          CREATE TABLE delivery (
            deliveryId INTEGER PRIMARY KEY AUTOINCREMENT,
            strikerId INTEGER NOT NULL,
            nonStrikerId INTEGER NOT NULL,
            bowlerID INTEGER NOT NULL,
            run INTEGER NOT NULL,
            overId INTEGER NOT NULL
            )
          ''');
  }
}
