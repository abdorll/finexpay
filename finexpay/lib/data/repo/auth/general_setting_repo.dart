import 'dart:convert';

import '../../../constants/method.dart';
import '../../../constants/my_strings.dart';
import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/utils/url_container.dart';
import '../../../data/services/api_service.dart';
import '../../model/general_setting/GeneralSettingMainModel.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';


class GeneralSettingRepo {

  ApiClient apiClient;

  GeneralSettingRepo({required this.apiClient});


  Future<dynamic> getGeneralSetting() async {

    try{
      String url='${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      return response;

    }catch(e){
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }

  }

  Future<dynamic> getLanguage(String languageCode) async {
    /*try{*/
      String url='${UrlContainer.baseUrl}${UrlContainer.languageUrl}$languageCode';
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      print(response.responseJson);
      print(url);
      return response;

   /* }catch(e){
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }*/

  }

  GeneralSettingMainModel getGeneralSettingFromSharedPreferences(){
    GeneralSettingMainModel model;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.generalSettingKey)) {
      String? obj =
      apiClient.sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey);
      if(obj!=null){
        model=GeneralSettingMainModel.fromJson(jsonDecode(obj));
      }
      model=GeneralSettingMainModel();
      return model;
    } else {
      model=GeneralSettingMainModel();
      return model;
    }
  }

  storeGeneralSetting(GeneralSettingMainModel model){
    String json=jsonEncode(model.toJson());
    apiClient.sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingMainModel getGSData(){
    String pre= apiClient.sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingMainModel model=GeneralSettingMainModel.fromJson(jsonDecode(pre));
    return model;
  }


}
