import 'dart:convert';

class DishModel {
  final String dishTitle;
  final String dishImageLink;
  final String description;
  final String typeOfDish;
  final int price;
  final int maxLimit;
  final int pending_limit;
  final bool isVegetarian;
  final bool isActive;


  DishModel(this.dishTitle,this.dishImageLink,this.typeOfDish,this.description,this.price,this.maxLimit,this.pending_limit,this.isVegetarian,this.isActive);

  Map<String, dynamic> toJson() {
    return {
      'dishTitle': dishTitle,
      'dishImageLink': dishImageLink,
      'typeOfDish':typeOfDish,
      'description':description,
      'price': price,
      'maxLimit': maxLimit,
      'pending_limit':pending_limit,
      'isVegetarian': isVegetarian,
      'isActive' : isActive
    };
  }

  factory DishModel.fromMap(Map<String, dynamic> map) {

    return DishModel(
        map['dishTitle'],
        map['dishImageLink'],
        map['typeOfDish'],
        map['description'],
        map['price'],
        map['maxLimit'],
        map['pending_limit'],
        map['isVegetarian'],
        map['isActive']
    );
  }

  factory DishModel.fromJson(String source) => DishModel.fromMap(
    json.decode(source),
  );
}
