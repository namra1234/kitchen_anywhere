import 'package:flutter/cupertino.dart';
import 'package:kitchen_anywhere/common/constants.dart';
import 'package:kitchen_anywhere/model/dishModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DishRepository {
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Dish');

  dynamic createDish(DishModel Dishmodel) async {

    try{
      final newDocRef = collection.doc();
      Map? DishMap = Dishmodel.toJson();
      await newDocRef.set(DishMap);
      return true;
    }
    catch(e){
      return false;
    }

  }

  dynamic getAllDish() async {

    final docSnapshot = await collection
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();

      List<DishModel> dishList=[];

      for(int i=0;i<snapshot.docs.length;i++)
        {
          Map<String, dynamic>? data=snapshot.docs[i].data() as Map<String, dynamic>?;
          String? dishTitle = data!["dishTitle"].toString();
          String dishImageLink = data['dishImageLink'].toString();
          String typeOfDish = data['typeOfDish'].toString();
          String description = data['description'].toString();
          double price = data['price'];
          double maxLimit = data['maxLimit'];
          double pending_limit = data['pending_limit'];
          bool isVegetarian  = data['isVegetarian'];
          bool isActive  = data['isActive'];

          Map? DishMap =  DishModel(dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,isVegetarian,isActive).toJson();
          dishList.add(DishModel.fromMap(DishMap as Map<String,dynamic>));
        }
      return dishList;

    });
  }

}
