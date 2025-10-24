import 'item_model.dart';
import 'user_model.dart';

class OrdersModel {
  final int? id;
  final int? numberOfSugarSpoons;
  final String? room;
  final String? itemId;
  final String? status;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ItemModel? item;
  final UserModel? user;
  final String? orderNotes;

  OrdersModel({
    this.id,
    this.numberOfSugarSpoons,
    this.room,
    this.itemId,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.user,
    this.orderNotes,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json["id"],
      numberOfSugarSpoons: json["number_of_sugar_spoons"],
      room: json["room"],
      itemId: json["item_id"].toString(),
      status: json["status"],
      userId: json["user_id"].toString(),
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
      orderNotes: json["order_notes"],
      item: json["item"] != null ? ItemModel.fromJson(json["item"]) : null,
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "number_of_sugar_spoons": numberOfSugarSpoons,
      "room": room,
      "item_id": itemId,
      "status": status,
      "user_id": userId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "order_notes": orderNotes,
      "item": item?.toJson(),
      "user": user?.toJson(),
    };
  }

  @override
  String toString() {
    return 'OrdersModel(id: $id, room: $room, status: $status, item: ${item?.name}, user: ${user?.name}, spoons: $numberOfSugarSpoons)';
  }
}
