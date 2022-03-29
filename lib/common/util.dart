import 'dart:math';

import 'package:intl/intl.dart';

import 'constants.dart';

class Util {
  
  static DateTime stringDatetoDateTime(String date,DateFormat dateFormat)
  {    
        DateFormat df;
    if(dateFormat==null || dateFormat=="")
    {
      df=Constants.commondateFormate;
    }
    else
    {
      df=dateFormat;
    }

    DateTime parsedDate = df.parse(date);
    return parsedDate;   
  }

  static String dateTimeDatetoString(DateTime date,DateFormat dateFormat)
  {    
    DateFormat df;
    if(dateFormat==null || dateFormat=="")
    {
      df=Constants.commondateFormate;
    }
    else
    {
      df=dateFormat;
    }

    String dateString = df.format(date);
    return dateString;   
  }

    static DateTime currentDate()
  {    
    return DateTime.now();   
  }


    static DateTime getBeforeDateTime({DateTime ?date,int days=0,int hours=0,int minutes=0,int seconds=0})
  {    
    if(date==null)
    {
      date=currentDate();
    }
    DateTime beforeDate=date.subtract(new Duration(days: days,hours: hours,minutes: minutes,seconds: seconds));
    return beforeDate;   
  }

   static DateTime getAfterDateTime({DateTime ?date,int days=0,int hours=0,int minutes=0,int seconds=0})
  {    
    if(date==null)
    {
      date=currentDate();
    }

    DateTime afterDate = date.add(new Duration(days: days,hours: hours,minutes: minutes,seconds: seconds));  
    return  afterDate;
  }

}
