import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/core/utils/styles.dart';

import '../../../../core/utils/my_color.dart';
import '../../core/helper/string_format_helper.dart';

class CustomSnackbar {

  static  showCustomSnackbar({required List<String>errorList,required List<String> msg,required bool isError,int duration=5}){
    String message='';
    if(isError){
      if(errorList.isEmpty){
        message = MyStrings.unknownError.tr;
      }else{
        for (var element in errorList) {
          message=message.isEmpty?'$message${element.tr}':"$message\n${element.tr}";
        }
      }
      message=CustomValueConverter.removeQuotationAndSpecialCharacterFromString(message);
    } else{
      if(msg.isEmpty){
        message= MyStrings.success.tr ;
      }else{
        for (var element in msg) {
          message=message.isEmpty?'$message${element.tr}':"$message\n${element.tr}";
        }
      }

      message=CustomValueConverter.removeQuotationAndSpecialCharacterFromString(message);
    }

    Get.rawSnackbar(
      progressIndicatorBackgroundColor: isError?MyColor.redCancelTextColor: MyColor.greenSuccessColor,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(isError?MyColor.redCancelTextColor: MyColor.greenSuccessColor ),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2,),
          Text(message.tr,style: robotoRegular,),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(!isError?MyStrings.success.tr:MyStrings.error.tr,style: mulishBold.copyWith(fontSize: Dimensions.fontLarge),),
        SvgPicture.asset(isError?MyImages.errorImage:MyIcons.completedTradeIcon,height: 25,width: 25,color:isError?MyColor.redCancelTextColor: MyColor.greenSuccessColor ,)
        ],
      ),
      backgroundColor: MyColor.colorWhite,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.colorWhite,
      animationDuration: const Duration(seconds: 1),
      borderColor: MyColor.borderColor,
      reverseAnimationCurve:Curves.easeOut,
      borderWidth: 2,
    );
  }

  static showSnackbarWithoutTitle(BuildContext context,String message,{Color bg=MyColor.greenSuccessColor}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        content: Text(message.tr),
      ),
    );
  }





}