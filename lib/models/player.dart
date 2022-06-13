class Player{
  late int id;
  late String name;
  late String category;

  Player({
    required this.id,
    required this.name,
    required this.category});

  Player.fromMap(dynamic obj) {
    id = obj['playerId'];
    name = obj['playerName'];
    category = obj['FK_player_category'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'playerName': name,
      'FK_player_category':category,
    };
    return map;
  }
}
