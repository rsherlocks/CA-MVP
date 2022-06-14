import 'package:ca_mvp/data/database.dart';
import 'package:ca_mvp/models/delivery.dart';

class DeliveryOperations {
  late DeliveryOperations deliveryOperations;
  final dbProvider = DatabaseRepository.instance;
  

  createDelivery(DeliveryBall deliveryBall) async {
    final db = await dbProvider.database;
    var abc = db?.insert('delivery', deliveryBall.toMap());
    return abc;
  }

  deleteDeliveryById(int id) async{
    final db = await dbProvider.database;
    db?.delete('delivery');
    print("delivery deleted");
  }

  Future<List<DeliveryBall>?> getAllDelivery() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('delivery');
    List<DeliveryBall>? deliveries =
        allRows?.map((delivery) => DeliveryBall.fromMap(delivery)).toList();
    return deliveries;
  }
  Future<List?> searchAllDeliveryByOverId(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('delivery', where: 'overId LIKE ?', whereArgs: ['%$id%']);
    List? deliveries =
    allRows?.map((delivery) => DeliveryBall.fromMap(delivery)).toList();
    return deliveries;
  }

  searchDeliveryById(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? allRows = await db?.query('delivery', where: 'deliveryId LIKE ?', whereArgs: ['%$id%']);
    List? deliveries =
    allRows?.map((delivery) => DeliveryBall.fromMap(delivery)).toList();
    return deliveries![0];
  }

}
