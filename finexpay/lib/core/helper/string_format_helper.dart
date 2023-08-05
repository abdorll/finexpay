import 'package:get/get.dart';

class CustomValueConverter {
  static String roundDoubleAndRemoveTrailingZero(String value) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
      return b;
    } catch (e) {
      return value;
    }
  }

  static String twoDecimalPlaceFixedWithoutRounding(String value,{int precision=2}) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(precision);
      return b;
    } catch (e) {
      return value;
    }
  }

  static String removeQuotationAndSpecialCharacterFromString(String value) {
    try {
      String formatedString =
          value.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '');
      return formatedString;
    } catch (e) {
      return value;
    }
  }

  static String replaceUnderscoreWithSpace(String value) {

    try {
      String formatedString = value.replaceAll('_', ' ');
      String v=formatedString.split(" ").map((str) => str.capitalize).join(" ");
      return v;
    } catch (e) {
      return value;
    }

  }


  static String getFormatedDateWithStatus(String inputValue){
    String value=inputValue;
    try{
      var list=inputValue.split(' ');
      var dateSection=list[0].split('-');
      var timeSection=list[1].split(':');
      int year=int.parse(dateSection[0]);
     int month=int.parse(dateSection[1]);
      int day=int.parse(dateSection[2]);
      int hour=int.parse(timeSection[0]);
      int minute=int.parse(timeSection[1]);
      int second=int.parse(timeSection[2]);
      final startTime = DateTime(year,month,day,hour,minute,second);
      final currentTime = DateTime.now();


      int dayDef = currentTime.difference(startTime).inDays;
      int hourDef = currentTime.difference(startTime).inHours;
      final minDef = currentTime.difference(startTime).inMinutes;
      final secondDef = currentTime.difference(startTime).inSeconds;


     if(dayDef==0){
       if(hourDef<=0){
         if(minDef<=0){
           value='$secondDef second ago';
         }else{
           value='$hourDef minutes ago';
         }
       }else{
         value='$hourDef hour ago';
       }
     }
     else{
       value='$dayDef days ago';
     }
    }catch(e){
        value=inputValue;
    }

    return value;
  }


  static String getTrailingExtension(int number){
    List<String>list=['th','st','nd','rd','th','th','th','th','th','th'];
    if(((number % 100)>=11) && ((number%100)<=13)){
      return '${number}th';
    }else{

      int value=(number%10).toInt();
      return '$number${list[value]}';
    }
  }


  static String addLeadingZero(String value){
        return value.padLeft(2,'0');
  }

  static getBottomSheetHeight(int list,{bool hasHeader = false}) {
    if(hasHeader){
      return list==1?0.21:list==2?0.3:list==3?0.42:list==4?0.52:list==5?0.62:0.7;
    }else{
      return list==1?0.2:list==2?0.25:list==3?0.35:list==4?0.45:list==5?0.55:0.6;
    }
  }

  static checkError(String value,int index){
    bool b = false;
    if(index==0){
     b = value.contains(RegExp(r'[A-Z]'))?false:true;
    } else if(index==1){
     b = value.contains(RegExp(r'[a-z]'))?false:true;
    } else if(index==2){
     b = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))?false:true;
    } else if(index==3){
     b = value.contains(RegExp(r'[0-9]'))?false:true;
    } else if(index==4){
     b = value.length>=6?false:true;
    } else{
     b = false;
    }
   return b;
  }

}
