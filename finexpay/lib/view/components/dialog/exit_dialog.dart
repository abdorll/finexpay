import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/view/components/rounded_button.dart';



  showExitDialog(BuildContext context){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.colorWhite,
      width: 300,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: MyStrings.exitTitle.tr,
      padding: const EdgeInsets.only(left: 8,right: 8,top:8),
      titleTextStyle: mulishSemiBold.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontExtraLarge),
      showCloseIcon: false,
      btnCancel: RoundedButton(textColor:MyColor.colorWhite,text: MyStrings.no.tr, press: (){
        Navigator.pop(context);
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.colorBlack,),
      btnOk: RoundedButton(text: MyStrings.yes.tr, press: (){
        SystemNavigator.pop();
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.red,textColor: MyColor.colorWhite,),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
    ).show();
  }
