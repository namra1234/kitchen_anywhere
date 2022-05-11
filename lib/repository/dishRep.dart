import 'dart:math';

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

  Future<List<DishModel>> getAllDish() async {
    List<DishModel> dishList=[];
    final docSnapshot = await collection
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();



      for(int i=0;i<snapshot.docs.length;i++)
        {
          Map<String, dynamic>? data=snapshot.docs[i].data() as Map<String, dynamic>?;
          String? dishTitle = data!["dishTitle"].toString();
          String dishImageLink = data['dishImageLink'].toString();
          String typeOfDish = data['typeOfDish'].toString();
          String description = data['description'].toString();
          double price = double.parse(data['price'].toString());
          int maxLimit = data['maxLimit'].toInt();
          int categoryId = data['categoryId'].toInt();
          int pending_limit = data['pending_limit'].toInt();
          bool isVegetarian  = data['isVegetarian'];
          bool isActive  = data['isActive'];


          Random random = Random();
          int _randomNumber1 = random.nextInt(5);

          Map? DishMap =  DishModel(dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
              isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,0

          ).toJson();
          dishList.add(DishModel.fromMap(DishMap as Map<String,dynamic>));
        }


    });

    return dishList;
  }

  Future<List<DishModel>> getChefAllDish(String chef_id) async {
    List<DishModel> dishList=[];
    final docSnapshot = await collection.where("chef_id", isEqualTo: chef_id)
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();



      for(int i=0;i<snapshot.docs.length;i++)
      {
        Map<String, dynamic>? data=snapshot.docs[i].data() as Map<String, dynamic>?;
        String? dishTitle = data!["dishTitle"].toString();
        String dishImageLink = data['dishImageLink'].toString();
        String typeOfDish = data['typeOfDish'].toString();
        String description = data['description'].toString();
        double price = double.parse(data['price'].toString());
        int maxLimit = data['maxLimit'].toInt();
        int categoryId = data['categoryId'].toInt();
        int pending_limit = data['pending_limit'].toInt();
        bool isVegetarian  = data['isVegetarian'];
        bool isActive  = data['isActive'];


        Random random = Random();
        int _randomNumber1 = random.nextInt(5);

        Map? DishMap =  DishModel(dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
            isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,0

        ).toJson();
        dishList.add(DishModel.fromMap(DishMap as Map<String,dynamic>));
      }


    });

    return dishList;
  }

}
