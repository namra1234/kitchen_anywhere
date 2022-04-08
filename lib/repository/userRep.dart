
import 'package:flutter/cupertino.dart';

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
        UserMap['id'] = newDocRef.id;
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

}
