

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/messages.dart';
import 'package:local_coin/data/controller/localization/localization_controller.dart';

import '../../../../view/components/show_custom_snackbar.dart';
import  '../../../core/helper/shared_pref_helper.dart';
import '../../core/route/route.dart';
import '../model/general_setting/GeneralSettingsResponseModel.dart';
import '../model/global/response_model/response_model.dart';
import '../repo/auth/general_setting_repo.dart';


class SplashController extends GetxController  {

  GeneralSettingRepo repo;
  LocalizationController localizationController;
  bool isLoading = true;

  SplashController({required this.repo,required this.localizationController});

  gotoNextPage() async {

    await loadLanguage();

    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    noInternet=false;
    update();


    try{
      RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null && initialMessage.data.isNotEmpty) {
        repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,true);
        String tradeId='';
        try{
          String clickUrl = initialMessage.data['click_url'];
          tradeId=clickUrl.split('details/')[1];
        }catch(e){
         tradeId='';
        }

        if(isRemember&&tradeId.isNotEmpty){
            Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: tradeId);
          }
          else{
          Get.toNamed(RouteHelper.loginScreen);
        }
        return;
      }else{
        getGSData(isRemember);
        return;
      }

    }catch(e){
      Get.offAndToNamed(RouteHelper.loginScreen);
    }


  }

  bool noInternet=false;
  void getGSData(bool isRemember)async{
    ResponseModel response = await repo.getGeneralSetting();
    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
        repo.apiClient.storeGeneralSetting(model);
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackbar.showCustomSnackbar(errorList:model.message?.error??message, msg:[], isError: true);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackbar.showCustomSnackbar(errorList:[response.message], msg:[], isError: true);
      return;
    }


    isLoading = false;
    update();



    if (isRemember) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(RouteHelper.homeScreen);
      });
    }
    else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(RouteHelper.loginScreen);
      });
    }
  }

  Future<bool> initSharedData() {

    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, MyStrings.languages[0].countryCode);
    }
    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, MyStrings.languages[0].languageCode);
    }

    return Future.value(true);
  }

  Future<void>loadLanguage()async{
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;
    ResponseModel response = await repo.getLanguage(languageCode);
    if(response.statusCode == 200){
      try{
        Map<String,Map<String,String>> language = {};
        saveLanguageList(response.responseJson);
        var resJson = jsonDecode(response.responseJson);
        await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, response.responseJson);
        var langKeyList = jsonDecode(resJson['data']['file']);
        Map<String,String> json = {};
        if(langKeyList is Map<String,dynamic>){
          langKeyList.forEach((key, value) {
            json[key] = value.toString();
          });
        }
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
        Get.addTranslations(Messages(languages: language).keys);
      }catch(e){
        CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true);
      }

    } else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
    }

  }

  void saveLanguageList(String languageJson)async{
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }
}
