import 'package:flutter/material.dart';

class MyDateUtil{
  //for getting formatted time from milliSecondsSinceEpoch String
  static String getformattedTime({
    required BuildContext context, required String time
  }){
    final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }


  //get last message time in user chat card 
   String getLastMessageTime({
    required BuildContext context, required String time
  }){
    final DateTime sent  = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    if (now.day == sent.day && now.month == sent.month && now.year == sent.year){
      return TimeOfDay.fromDateTime(sent).format(context);

    }

    return '${sent.day} ${_getMonth(sent)}';

  }

  static String _getMonth(DateTime date){
    switch( date.month){
      case 1:
      return 'Jan';
      case 2:
      return 'Feb';
      case 3:
      return 'Mar';
      case 4:
      return 'Apr';
      case 5:
      return 'May';
      case 6:
      return 'Jun';
      case 7:
      return 'Jul';
      case 8:
      return 'Aug';
      case 9:
      return 'Sep';
      case 10:
      return 'Oct';
      case 11:
      return 'Nov';
      case 12:
      return 'Dec';
    }
    return 'NA';
  }

  }
