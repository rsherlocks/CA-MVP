class Score{
  late int id;
  late int matchId;
  late int overSerial;
  late String deliveriesBall;


  Score({required this.id,required this.matchId,required this.overSerial,required this.deliveriesBall});

  Score.fromMap(dynamic obj) {
    this.id = obj['scoreId'];
    this.matchId = obj['matchId'];
    this.overSerial = obj['overSerial'];
    this.deliveriesBall = obj['deliverBalls'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'matchId': matchId,
      'overSerial': overSerial,
      'deliverBalls': deliveriesBall,
    };
    return map;
  }
}
