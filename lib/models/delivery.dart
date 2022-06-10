class DeliveryBall{
  late int id;
  late int strikerId;
  late int nonStrikerId;
  late int bowlerId;
  late int run;
  late int overId;


  DeliveryBall({required this.id,required this.strikerId,required this.nonStrikerId,required this.bowlerId,required this.run,required this.overId});

  DeliveryBall.fromMap(dynamic obj) {
    this.id = obj['deliveryBallId'];
    this.strikerId = obj['strikerId'];
    this.nonStrikerId = obj['nonStrikerId'];
    this.bowlerId = obj['bowlerId'];
    this.run = obj['run'];
    this.overId = obj['overId'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'strikerId': strikerId,
      'nonStrikerId': nonStrikerId,
      'bowlerId': bowlerId,
      'run': run,
      'overId': overId,
    };
    return map;
  }
}
