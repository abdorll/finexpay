

import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/repo/menu_repo/menu_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';


class MyMenuController extends GetxController{

  MenuRepo repo;
  MyMenuController({required this.repo});

  bool logoutLoading = false;

  bool langSwitchEnable  = true;

  Future<void>logout()async{
    List<String>msg = [];
    logoutLoading = true;
    update();
    ResponseModel response = await repo.logout();
    if(response.statusCode == 200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase() == MyStrings.success.toLowerCase() || model.status?.toLowerCase() == 'ok'){
        msg.addAll(model.message?.success??[MyStrings.logoutSuccessMsg]);
      } else{
        msg.add(MyStrings.logoutSuccessMsg);
      }
    } else{
      msg.add(MyStrings.logoutSuccessMsg);
    }
    logoutLoading = false;
    update();
    repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.screenLockPin, '');
    Get.offAllNamed(RouteHelper.loginScreen);
    CustomSnackbar.showCustomSnackbar(errorList: [], msg: msg, isError: false);
  }

  String screenPin = '';
  void loadPin()async{
    screenPin = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.screenLockPin)??'';
    if(screenPin.isEmpty){
      await logout();
    }
    update();
  }

}