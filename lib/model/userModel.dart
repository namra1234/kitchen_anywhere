import 'dart:convert';

class UserModel {
  final String userAddress;
  final String userEmail;
  final String userID;
  final String id;
  final String userPhone;

  UserModel( this.userEmail, this.userID, this.id,this.userAddress,this.userPhone);

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'userID': userID,
      'id': id,
      'userAddress': userAddress,
      'userPhone': userPhone
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {

    return UserModel(
        map['userEmail'],
         map['userID'],
         map['id'],
        map['userAddress'],
    map['userPhone']);
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        json.decode(source),
      );
}
