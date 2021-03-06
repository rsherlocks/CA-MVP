import 'package:ca_mvp/data/database.dart';
import 'package:ca_mvp/models/player.dart';
import 'package:ca_mvp/models/team.dart';

class TeamOperations {
  late TeamOperations teamOperations;
  final dbProvider = DatabaseRepository.instance;

  createTeam(Team team) async {
    final db = await dbProvider.database;
    db?.insert('team', team.toMap());
    print('team inserted');
  }

  Future<List<Team>?> getAllTeam() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.rawQuery('''
    SELECT * FROM team''');
    List<Team>? teams = allRows?.map((teams) => Team.fromMap(teams)).toList();
    return teams;
  }

  Future<List<Player>?> getAllTeamQuery() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.rawQuery('''
    SELECT * FROM player  INNER JOIN team ON player.playerId = team.playerIdOne''');
    List<Player>? teams = allRows?.map((teams) => Player.fromMap(teams)).toList();
    return teams;
  }

  Future<List?> searchAllTeamByName(String team) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('team', where: 'teamName LIKE ?', whereArgs: ['%$team%']);
    List? teams =
    allRows?.map((team) => Team.fromMap(team)).toList();
    return teams;
  }
}
