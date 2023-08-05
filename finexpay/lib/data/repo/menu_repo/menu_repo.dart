
import 'package:local_coin/constants/method.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';

import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/services/api_service.dart';

class MenuRepo{
  ApiClient apiClient;

  MenuRepo({required this.apiClient});

  Future<ResponseModel>logout()async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.logoutEndPoint}';
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null,passHeader: true);
    await clearSharedPrefData();
    return responseModel;
  }

 Future<void> clearSharedPrefData()async{
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    await apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    return Future.value();
  }
}