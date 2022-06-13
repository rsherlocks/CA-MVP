class Match{
  late int id;
  late int teamIdOne;
  late int teamIdTwo;
  late String matchName;
  late int scoreId;


  Match({required this.id,required this.teamIdOne,required this.teamIdTwo,required this.matchName,required this.scoreId});

  Match.fromMap(dynamic obj) {
    id = obj['matchId'];
    matchName = obj['matchName'];
    teamIdOne = obj['teamIdOne'];
    teamIdTwo = obj['teamIdTwo'];
    scoreId = obj['scoreId'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'teamIdOne': teamIdOne,
      'teamIdTwo': teamIdTwo,
      'matchName': matchName,
      'scoreId': scoreId,
    };
    return map;
  }
}
