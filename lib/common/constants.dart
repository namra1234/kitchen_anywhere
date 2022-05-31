import 'package:intl/intl.dart';
import 'package:kitchen_anywhere/model/dishModel.dart';
import 'package:kitchen_anywhere/model/userModel.dart';

import '../model/OrderModel.dart';

class firebase {}

class Constants {
  static List<DishModel> dish = [];
  static List<DishModel> cartList = [];
  static List<OrderModel> AllOrderList = [];
  static const int SPLASH_SCREEN_TIME = 2;
  static int processIndex = 0;
  static String loggedInUserID = "", myName = "", myEmail = "";
  static String appname = "Flutter App";
  static double height = 0, width = 0;
  static UserModel userdata = UserModel("", "", "", "", "", "", false);
  static DateFormat commondateFormate = DateFormat("yyyy-MM-dd hh:mm:ss");
  static DateFormat ymdFormate = DateFormat("yyyy-MM-dd");
  static DateFormat dmytFormate = DateFormat("dd-MM-yyyy hh:mm:ss");
  static DateFormat dmyt1Formate = DateFormat("dd/MM/yyyy hh:mm:ss");
  static DateFormat dmythmFormate = DateFormat("dd-MM-yyyy hh:mm");
  static DateFormat dmythm1Formate = DateFormat("dd/MM/yyyy hh:mm");
  static DateFormat hmsFormate = DateFormat("hh:mm:ss");
  static DateFormat hmFormate = DateFormat("hh:mm");
}

class validationMsg {
  static String emailNotEnter = 'Enter email';
  static String noInternet = 'Please connect to the internet to continue.';
}


