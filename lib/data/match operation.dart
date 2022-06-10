import 'package:ca_mvp/data/database.dart';
import 'package:ca_mvp/models/match.dart';

class MatchOperation {
  late MatchOperation matchOperations;
  final dbProvider = DatabaseRepository.instance;

  createMatch(Match match) async {
    final db = await dbProvider.database;
    db?.insert('match', match.toMap());
    print('match inserted');
  }

  Future<List<Match>?> getAllMatch() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('match');
    List<Match>? matches =
        allRows?.map((matches) => Match.fromMap(matches)).toList();
    return matches;
  }

  Future<List<Match>?> getAllMatchQuery() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.rawQuery('''
    SELECT * FROM match  INNER JOIN score ON match.matchId = score.matchId''');
    List<Match>? matches =
        allRows?.map((matches) => Match.fromMap(matches)).toList();
    return matches;
  }

  Future<List?> searchAllMatchById(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows =
        await db?.query('match', where: 'matchId LIKE ?', whereArgs: ['%$id%']);
    List? matches = allRows?.map((match) => Match.fromMap(match)).toList();
    return matches;
  }
}
