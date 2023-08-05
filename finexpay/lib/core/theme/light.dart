import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/my_color.dart';

ThemeData light = ThemeData(
    fontFamily: 'Mulish',
    primaryColor: MyColor.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: MyColor.colorWhite,
    hintColor: MyColor.colorBlack,
    focusColor: MyColor.gbr,
    unselectedWidgetColor: MyColor.colorBlack,
    dialogBackgroundColor:  MyColor.colorWhite,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color:MyColor.colorWhite,
      foregroundColor: Colors.red,
      systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
        statusBarColor: MyColor.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.primaryColor),
    ));
