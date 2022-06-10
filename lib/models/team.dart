class Team {
  late int id;
  late int playerIdOne;
  late int playerIdTwo;
  late int playerIdThree;
  late int playerIdFour;
  late int playerIdFive;
  late int playerIdSix;
  late int playerIdSeven;
  late int playerIdEight;
  late String teamName;


  Team(
  {
    required this.id,
    required this.playerIdOne,
    required this.playerIdTwo,
    required this.playerIdThree,
    required this.playerIdFour,
    required this.playerIdFive,
    required this.playerIdSix,
    required this.playerIdSeven,
    required this.playerIdEight,
    required this.teamName
});

  Team.fromMap(dynamic obj) {
    this.id = obj['teamId'];
    this.teamName = obj['teamName'];
    this.playerIdOne = obj['playerIdOne'];
    this.playerIdTwo = obj['playerIdTwo'];
    this.playerIdThree = obj['playerIdThree'];
    this.playerIdFour = obj['playerIdFour'];
    this.playerIdFive = obj['playerIdFive'];
    this.playerIdSix = obj['playerIdSix'];
    this.playerIdSeven = obj['playerIdSeven'];
    this.playerIdEight = obj['playerIdEight'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'teamName': teamName,
      'playerIdOne': playerIdOne,
      'playerIdTwo': playerIdTwo,
      'playerIdThree': playerIdThree,
      'playerIdFour': playerIdFour,
      'playerIdFive': playerIdFive,
      'playerIdSix': playerIdSix,
      'playerIdSeven': playerIdSeven,
      'playerIdEight': playerIdEight
    };
    return map;
  }
}
