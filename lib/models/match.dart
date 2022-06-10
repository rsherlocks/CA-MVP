class Match{
  late int id;
  late int teamIdOne;
  late int teamIdTwo;
  late String matchName;
  late int scoreId;


  Match({required this.id,required this.teamIdOne,required this.teamIdTwo,required this.matchName,required this.scoreId});

  Match.fromMap(dynamic obj) {
    this.id = obj['matchId'];
    this.matchName = obj['matchName'];
    this.teamIdOne = obj['teamIdOne'];
    this.teamIdTwo = obj['teamIdTwo'];
    this.scoreId = obj['scoreId'];
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
