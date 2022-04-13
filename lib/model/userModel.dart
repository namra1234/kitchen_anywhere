import 'dart:convert';

class UserModel {
  final String address;
  final String email;
  final String fullName;
  final String userID;
  final String phoneNo;
  final String postal_code;
  final bool isChef;

  UserModel(this.userID,this.email,this.fullName,  this.address,this.postal_code,this.phoneNo,this.isChef);

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'email': email,
      'fullName':fullName,
      'address': address,
      'postal_code': postal_code,
      'phoneNo': phoneNo,
      'isChef' : isChef
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {

    return UserModel(
        map['userID'],
        map['email'],
        map['fullName'],
        map['address'],
        map['postal_code'],
        map['phoneNo'],
        map['isChef']
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        json.decode(source),
      );
}
