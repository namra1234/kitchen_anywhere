
import 'package:flutter/cupertino.dart';
import 'package:kitchen_anywhere/common/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userModel.dart';

class UserRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('User');

  dynamic createUser(UserModel Usermodel) async {

    final docSnapshot = await collection
        .where("userID", isEqualTo: Usermodel.userID)
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();
      print(newDocRef);
      if (snapshot.docs.length == 0) {
        final newDocRef = collection.doc();
        Map? UserMap = Usermodel.toJson();
        // UserMap['id'] = newDocRef.id;
        await newDocRef.set(UserMap);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('id', newDocRef.id);
        return newDocRef;
      } else {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString('id', snapshot.docs.first.data()['id']);
        return null;
      }
    });
  }

  dynamic getUser(String userID) async {

    final docSnapshot = await collection
        .where("userID", isEqualTo: userID)
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();

      // dynamic d1=snapshot.docs[0].data();
        Map<String, dynamic>? data=snapshot.docs[0].data() as Map<String, dynamic>?;
        String? userID = data!["userID"].toString();
        String email = data['email'].toString();
        String fullName = data['fullName'].toString();
        String address = data['address'].toString();
        String postal_code = data['postal_code'].toString();
        String phoneNo = data['phoneNo'].toString();
        bool isChef  = data['isChef'];


      Map? UserMap =  UserModel(userID,email,fullName,address,postal_code,phoneNo,isChef).toJson();

      Constants.userdata=UserModel.fromMap(UserMap as Map<String,dynamic>);
        return UserMap;

    });
  }

}
