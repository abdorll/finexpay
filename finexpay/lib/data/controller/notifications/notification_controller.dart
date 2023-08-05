

import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/notification/NotificationResponseModel.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../repo/notification_repo/notification_repo.dart';

class NotificationsController extends GetxController {
  NotificationRepo repo;
  bool isLoading = true;

  NotificationsController({required this.repo});

  String? nextPageUrl;
  String? imageUrl;


   List<Data> notificationList = [];

   int page = 0;

   void clearActiveNotificationInfo(){
     repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,false);

   }

  Future<void> initData() async {
    page=page+1;
     if(page==1){
       notificationList.clear();
       isLoading=true;
       update();
     }

     ResponseModel response = await repo.loadAllNotification(page);
     if(response.statusCode==200){
       NotificationResponseModel model = NotificationResponseModel.fromJson(jsonDecode(response.responseJson));

       nextPageUrl=model.data?.notifications?.nextPageUrl;
       if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
         List<Data>?tempList= model.data?.notifications?.data;
         if(tempList!=null && tempList.isNotEmpty){
           notificationList.addAll(tempList);
         }
       }else{
         CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
       }
     }else{
       CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
     }

     if(page==1){
       isLoading=false;
     }
    update();
   }



  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl!.toLowerCase()!='null'? true : false;
  }



  Future<bool> markAsReadAndGotoThePage(int index) async {
        String? clickValue = notificationList[index].clickValue;
        String? remark = notificationList[index].remark;
        int? id = notificationList[index].id;
    if(remark!=null && remark.isNotEmpty){
      ResponseModel response = await repo.readNotification(id??0);
      if(response.statusCode==200){
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status!.toLowerCase()==MyStrings.success.toLowerCase()){
          checkAndRedirect(remark, clickValue);
        }else{
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
        }
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg:[], isError: true);
      }
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.noClickUrl], msg: [], isError: true);
    }

    return true;
  }

  checkAndRedirect(String remark,String? tradeId) async{

      if(remark.toLowerCase()=='BAL_ADD'.toLowerCase()
          ||remark.toLowerCase()=='BAL_SUB'.toLowerCase()){
        Get.toNamed(RouteHelper.transactionScreen);
      }else if(remark.toLowerCase()=='DEPOSIT_COMPLETE'.toLowerCase()){
        Get.toNamed(RouteHelper.depositHistoryScreen);
      }else if(remark.toLowerCase()=='WITHDRAW_APPROVE'.toLowerCase()
          ||remark.toLowerCase()=='WITHDRAW_REJECT'.toLowerCase()
          ||remark.toLowerCase()=='WITHDRAW_REQUEST'.toLowerCase()){
        Get.toNamed(RouteHelper.withdrawHistoryScreen);
      }else if(isTrade(remark)){
        if(tradeId!=null && tradeId.isNotEmpty){
          Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: tradeId);
        }
      }else if(remark.toLowerCase()=='TRADE_CHAT'.toLowerCase()){

        if(tradeId!=null && tradeId.isNotEmpty){
          Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: tradeId);
        }

      }


  }

  bool isTrade(String remark){
    if(remark.toLowerCase()=='NEW_TRADE'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_CANCELED'.toLowerCase()
        ||remark.toLowerCase()=='BUYER_PAID'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_REPORTED'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_COMPLETED'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_SETTLED'.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  String getIcon(String remark) {

     String myIcon = '';
    if(remark.toLowerCase()=='BAL_ADD'.toLowerCase()){
      myIcon = MyIcons.plusIcon;
    }else if(remark.toLowerCase()=='BAL_SUB'.toLowerCase()){
      myIcon = MyIcons.minusIcon;
    }else if(remark.toLowerCase()=='kyc_approve'||remark.toLowerCase()=='DEPOSIT_COMPLETE'.toLowerCase()||remark.toLowerCase()=='WITHDRAW_APPROVE'.toLowerCase()){
      myIcon=MyIcons.completedIcon;
    } else if(remark.toLowerCase()=='WITHDRAW_REJECT'.toLowerCase()
        ||remark.toLowerCase()=='kyc_reject'.toLowerCase()||remark.toLowerCase()=='TRADE_CANCELED'){
      myIcon = MyIcons.withdrawNewIcon;
    }else if(remark.toLowerCase()=='pass_reset_code'||remark.toLowerCase()=='pass_reset_done'.toLowerCase()){
      myIcon=MyIcons.lockIcon;
    }else if(remark.toLowerCase()=='trade_chat'){
      myIcon = MyIcons.chatIcon;
    } else if(remark.toLowerCase()=='TRADE_REPORTED'.toLowerCase()){
      myIcon = MyIcons.warningIcon;
    }
    else{
      myIcon = MyIcons.menuNotificationIcon;
    }
     return myIcon;
  }

  Color getIconColor(String remark) {

    Color iconColor = MyColor.greenSuccessColor;
    if(remark.toLowerCase()=='BAL_ADD'.toLowerCase()){
      iconColor = MyColor.greenSuccessColor;
    }else if(remark.toLowerCase()=='BAL_SUB'.toLowerCase()){
      iconColor = MyColor.redCancelTextColor;
    }else if(remark.toLowerCase()=='kyc_approve'||remark.toLowerCase()=='DEPOSIT_COMPLETE'.toLowerCase()||remark.toLowerCase()=='WITHDRAW_APPROVE'.toLowerCase()){
      iconColor = MyColor.greenSuccessColor;
    } else if(remark.toLowerCase()=='WITHDRAW_REJECT'.toLowerCase()
        ||remark.toLowerCase()=='kyc_reject'.toLowerCase()||remark.toLowerCase()=='TRADE_CANCELED'){
      iconColor = MyColor.redCancelTextColor;
    }else if(remark.toLowerCase()=='pass_reset_code'||remark.toLowerCase()=='pass_reset_done'.toLowerCase()){
      iconColor = MyColor.secondaryColor;
    }else if(remark.toLowerCase()=='trade_chat'){
      iconColor = MyColor.secondaryColor;
    } else if(remark.toLowerCase()=='TRADE_REPORTED'.toLowerCase()){
      iconColor = MyColor.redCancelTextColor;
    }
    else{
      iconColor = MyColor.card1;
    }
     return iconColor;
  }


}
