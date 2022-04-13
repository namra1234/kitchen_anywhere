import 'package:intl/intl.dart';
import 'package:kitchen_anywhere/model/userModel.dart';

class firebase
{

}

class Constants {
  static const int SPLASH_SCREEN_TIME = 2;
  static int processIndex=0;
  static String loggedInUserID="",myName="",myEmail="";
  static String appname="Flutter App";
  static double height=0,width=0;
  static UserModel userdata=UserModel("","","","","","",false);
  static DateFormat commondateFormate=DateFormat("yyyy-MM-dd hh:mm:ss");
  static DateFormat ymdFormate=DateFormat("yyyy-MM-dd");
  static DateFormat dmytFormate=DateFormat("dd-MM-yyyy hh:mm:ss");
  static DateFormat dmyt1Formate=DateFormat("dd/MM/yyyy hh:mm:ss");
  static DateFormat dmythmFormate=DateFormat("dd-MM-yyyy hh:mm");
  static DateFormat dmythm1Formate=DateFormat("dd/MM/yyyy hh:mm");
  static DateFormat hmsFormate=DateFormat("hh:mm:ss");
  static DateFormat hmFormate=DateFormat("hh:mm");
}

class validationMsg{
  static String emailNotEnter = 'Enter email';
  static String noInternet = 'Please connect to the internet to continue.';
}

 class reqserver{
  static String baseurl = 'https://php2.shaligraminfotech.com/owle/public/api/';
static String getBase1='php2.shaligraminfotech.com';
static String getBase2='/owle/public/api/';
static String imgbaseurl='http://guard-my-vote.s3.us-east-2.amazonaws.com/';



   static String loginUrl = 'auth/login';
   static String forgotpwdUrl = 'auth/forgot-password';
 static String getCMSpageUrl ='get-cms-page-links';
 static String logoutUrl = 'auth/logout';
 static String getSurveyCountUrl ='get-survey-count';
 static String getSurveyListUrl = 'get-survey-list';
 static String getSurveyQuestionUrl ='get-survey-questions';


 }