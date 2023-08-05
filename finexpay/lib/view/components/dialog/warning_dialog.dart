import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_icons.dart';
import '../../../core/utils/styles.dart';
import '../buttons/circle_button_with_icon.dart';
import '../rounded_button.dart';

class MyDialog{
  String? title;
  Color okBtnColor;
  Color cancelBtnColor;
  final void Function() press;
  MyDialog(this.title,{required this.press,this.okBtnColor=MyColor.green,this.cancelBtnColor=MyColor.colorBlack});
  void showAlertDialog(BuildContext context) async{
    Get.defaultDialog(
        title: '',
        backgroundColor: MyColor.colorWhite,
        contentPadding: const EdgeInsets.all(0),
        titlePadding: const EdgeInsets.all(0),
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
        radius: 6,
        content: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: MyColor.colorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Center(
                child: CircleButtonWithIcon(
                  press: (){},
                  isIcon: true,
                  isSvg: true,
                  imagePath: MyIcons.questionIcon,
                  bg: MyColor.bgColor1,
                  circleSize: 38,
                  padding: 8,
                  iconSize: 30,
                  iconColor: MyColor.primaryColor,
                ),
              ),
              const SizedBox(height: 25,),
              Center(
                child: Text(
                  (title??'').tr,
                  style:
                  mulishBold.copyWith(fontSize: Dimensions.fontLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25,),
              const Divider(color: MyColor.borderColor,height: 1,),
              const SizedBox(height: 25,),
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(child: RoundedButton(
                      textColor:MyColor.colorWhite,
                      horizontalPadding: 12,verticalPadding: 12,
                      press: (){
                        Get.back();
                      },text: MyStrings.no.tr,color: cancelBtnColor,)),
                    const SizedBox(width: 20,),
                    Expanded(child:
                    RoundedButton(
                      horizontalPadding: 12,verticalPadding: 12,
                      press: press,text: MyStrings.yes.tr,color: okBtnColor,)),
                  ],
                ),
              )
            ],
          ),
        ));

  }
}
