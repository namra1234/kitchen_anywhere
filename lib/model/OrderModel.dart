import 'dart:convert';
import 'dishModel.dart';


class OrderModel {
  final String? id;
  final String chefId;
  final String contactOfFoodie;
  final List<DishModel> dishList;
  final String nameOfFoodie;
  final DateTime orderDate;
  final String orderId;
  final String orderStatus;
  final String userId;


  OrderModel(this.id,this.chefId,this.contactOfFoodie,this.dishList,this.nameOfFoodie,
      this.orderDate,this.orderId,this.orderStatus,this.userId);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chefId': chefId,
      'contactOfFoodie': contactOfFoodie,
      'dishList':dishList,
      'nameOfFoodie':nameOfFoodie,
      'orderDate': orderDate,
      'orderId': orderId,
      'orderStatus':orderStatus,
      'userId': userId
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {

    return OrderModel(
        map['id'],
        map['chefId'],
        map['contactOfFoodie'],
        map['dishList'],
        map['nameOfFoodie'],
        map['orderDate'],
        map['orderId'],
        map['orderStatus'],
        map['userId'],
    );
  }

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(
    json.decode(source),
  );
}
