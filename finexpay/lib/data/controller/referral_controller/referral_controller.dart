
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/data/model/referral/ReferralCommissionResponseModel.dart';
import 'package:local_coin/data/model/referral/ReferralUserResponseModel.dart' as ReferralUser;
import 'package:local_coin/data/repo/referral_repo/referral_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class ReferralController extends GetxController{

  
  ReferralRepo repo;
  ReferralController({required this.repo});
  List<Data>referralCommissionList=[];
  List<ReferralUser.ReferralUsers>userDataList=[];
  String?userNextPageUrl;
  String?commissionNextPageUrl;
  int commissionIndex=0;
  int userIndex=0;
  String cryptoImagePath='';



  bool isLoading = true;

 Future<void> loadInitialReferralCommission() async {
   commissionIndex=commissionIndex+1;
     if(commissionIndex==1){
       isLoading = true;
       referralCommissionList.clear();
       update();
     }

    ResponseModel response = await repo.getReferralCommission(commissionIndex);

    if (response.statusCode == 200)
    {

            ReferralCommissionResponseModel model =
            ReferralCommissionResponseModel.fromJson(
                jsonDecode(response.responseJson));
            cryptoImagePath=model.data?.cryptoImagePath??'';
            if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
              List<Data>? tempCommissionList = model.data?.referralLogs?.data;
               commissionNextPageUrl=model.data?.referralLogs?.nextPageUrl;
              if (tempCommissionList != null && tempCommissionList.isNotEmpty) {
               referralCommissionList.addAll(tempCommissionList);
              }

    } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [''], msg: [], isError: true);
            }
    } else {
        CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
    }

    if(commissionIndex==1){
      isLoading = false;
    }
    update();
  }

 Future<void> loadInitialReferralUser() async {

   userIndex=userIndex+1;
   if(userIndex==1){
     isLoading = true;
     update();
     userDataList.clear();
   }

    ResponseModel response = await repo.getReferralUser(commissionIndex);

    if (response.statusCode == 200) {
      ReferralUser.ReferralUserResponseModel model =
      ReferralUser.ReferralUserResponseModel.fromJson(
          jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

        List<ReferralUser.ReferralUsers>? tempUserList = model.data?.referralUsers;

        if (tempUserList != null && tempUserList.isNotEmpty) {
         userDataList.addAll(tempUserList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [''], msg: [], isError: true);
      }
    }
    else {
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
    }
    if(userIndex==1){
      isLoading = false;
    }
    update();
  }


  bool hasNext(bool fromUser){
   try{
     return fromUser?userNextPageUrl!=null && userNextPageUrl!.isNotEmpty?true:false:commissionNextPageUrl!=null && commissionNextPageUrl!.isNotEmpty?true:false;

   }catch(e){
     return false;
   }
  }


  bool isCommissionsSelected=true;

  void changeTabMenu(){
    isCommissionsSelected=!isCommissionsSelected;
    update();
  }

  int getFormattedValue(String s) {
    return int.tryParse(s)??0;
  }

}