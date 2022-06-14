
import 'package:ca_mvp/data/database.dart';
import 'package:ca_mvp/models/score.dart';

class ScoreOperation{
  late ScoreOperation scoreOperations;
  final dbProvider = DatabaseRepository.instance;

  createScore(Score score) async {
    final db = await dbProvider.database;
    db?.insert('score', score.toMap());
    print('score inserted');
  }

  Future<List<Score>?> getAllScore() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('score');
    List<Score>? scores = allRows?.map((scores) => Score.fromMap(scores)).toList();
    return scores;
  }

  searchScoreByMatchIdAndOverNumber(int matchId, int overNumber) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('score', where: 'matchId LIKE ? and overSerial = ?', whereArgs: ['%$matchId%', overNumber]);
    List? scores = allRows?.map((score) => Score.fromMap(score)).toList();
    return scores![0];
  }

  Future<List?> searchAllScoreById(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('score', where: 'scoreId LIKE ?', whereArgs: ['%$id%']);
    List? scores =
    allRows?.map((score) => Score.fromMap(score)).toList();
    return scores;
  }
}