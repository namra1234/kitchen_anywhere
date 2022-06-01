import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:kitchen_anywhere/common/constants.dart';
import 'package:kitchen_anywhere/model/dishModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DishRepository {
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Dish');

  dynamic createDish(Map<String, dynamic> Dishmodel) async {

    try{
      final newDocRef = collection.doc();
      await newDocRef.set(Dishmodel);
      return true;
    }
    catch(e){
      print(e);
      return false;
    }

  }
  dynamic updateDish(Map<String, Object?> Dishmodel,String? docId) async{
    try{
      final newDocRef = collection.doc(docId);
      // Map DishMap = Dishmodel.toJson();
      await newDocRef.update(Dishmodel);
      return true;
    }
    catch(e){
      return false;
    }
  }
  dynamic deleteDish(String? docId) async{
    try{
      final newDocRef = collection.doc(docId);
      // Map DishMap = Dishmodel.toJson();
      await newDocRef.delete();
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
          String? id = data!["chef_id"].toString();
          String? dishTitle = data!["dishTitle"].toString();
          String dishImageLink = data['dishImageLink'].toString();
          String typeOfDish = data['typeOfDish'].toString();
          String description = data['description'].toString();
          String postal_code = data['postal_code'].toString();
          double price = double.parse(data['price'].toString());
          int maxLimit = data['maxLimit'].toInt();
          int categoryId = data['categoryId'].toInt();
          int pending_limit = data['pending_limit'].toInt();
          bool isVegetarian  = data['isVegetarian'];
          bool isActive  = data['isActive'];


          Random random = Random();
          int _randomNumber1 = random.nextInt(5);

          Map? DishMap =  DishModel(id,dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
              isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,0,postal_code
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
        String? id = snapshot.docs[i].id;
        String? dishTitle = data!["dishTitle"].toString();
        String dishImageLink = data['dishImageLink'].toString();
        String typeOfDish = data['typeOfDish'].toString();
        String description = data['description'].toString();
        double price = double.parse(data['price'].toString());
        int maxLimit = data['maxLimit'].toInt();
        String postal_code = data['postal_code'].toString();
        int categoryId = data['categoryId'].toInt();
        int pending_limit = data['pending_limit'].toInt();
        bool isVegetarian  = data['isVegetarian'];
        bool isActive  = data['isActive'];


        Random random = Random();
        int _randomNumber1 = random.nextInt(5);

        Map? DishMap =  DishModel(id,dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
            isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,0,postal_code

        ).toJson();
        dishList.add(DishModel.fromMap(DishMap as Map<String,dynamic>));
      }


    });

    return dishList;
  }

}
