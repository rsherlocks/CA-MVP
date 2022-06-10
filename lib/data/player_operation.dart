import 'package:ca_mvp/data/database.dart';
import 'package:ca_mvp/models/player.dart';
import 'package:flutter/cupertino.dart';

class PlayerOperations {
  late PlayerOperations playerOperations;
  final dbProvider = DatabaseRepository.instance;

  createPlayer(Player player) async {
    final db = await dbProvider.database;
    db?.insert('player', player.toMap());
    print('player inserted');
  }

  Future<List<Player>?> getAllPlayer() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('player');
    List<Player>? players =
        allRows?.map((player) => Player.fromMap(player)).toList();

    return players;
  }

  Future<List?> searchAllPlayerByName(String player) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('player', where: 'playerName LIKE ?', whereArgs: ['%$player%']);
    List? players =
    allRows?.map((player) => Player.fromMap(player)).toList();
    return players;
  }
}
