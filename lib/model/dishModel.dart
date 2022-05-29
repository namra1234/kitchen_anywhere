import 'dart:convert';

class DishModel {
  final String? id;
  final String dishTitle;
  final String dishImageLink;
  final String description;
  final String typeOfDish;
  final String chef_id;
  final String postal_code;
  final double price;
  final int maxLimit;
  final int pending_limit;
  final bool isVegetarian;
  final bool isActive;

  final int categoryId;
  final List<String> favouriteUserID;
  final int start;
  int qty;


  DishModel(this.id,this.dishTitle,this.dishImageLink,this.typeOfDish,this.description,
      this.price,this.maxLimit,this.pending_limit,this.isVegetarian,this.isActive,this.chef_id,
      this.categoryId,this.favouriteUserID,this.start,this.qty,this.postal_code
      );

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'dishTitle': dishTitle,
      'dishImageLink': dishImageLink,
      'typeOfDish':typeOfDish,
      'description':description,
      'price': price,
      'maxLimit': maxLimit,
      'pending_limit':pending_limit,
      'isVegetarian': isVegetarian,
      'isActive' : isActive,
      'chef_id' : chef_id,
      'categoryId': categoryId,
      'favouriteUserID' : favouriteUserID,
      'start' : start,
      'qty':this.qty,
      'postal_code':this.postal_code
    };
  }

  factory DishModel.fromMap(Map<String, dynamic> map) {

    List<String> temp = [];
    temp.add("");

    int maxLimit = map['maxLimit'].toInt();
    int categoryId = map['categoryId'].toInt();
    int pending_limit = map['pending_limit'].toInt();

    maxLimit=10;
    return DishModel(
        map['id'],
        map['dishTitle'],
        map['dishImageLink'],
        map['typeOfDish'],
        map['description'],
        double.parse(map['price'].toString()),
        maxLimit,
        pending_limit,
        map['isVegetarian'],
        map['isActive'],
        map['chef_id'],
        categoryId,
        [],
        5,
        map['qty'],
        map['postal_code']==null ? "" : map['postal_code']
    );
  }

  factory DishModel.fromJson(String source) => DishModel.fromMap(
    json.decode(source),
  );
}
