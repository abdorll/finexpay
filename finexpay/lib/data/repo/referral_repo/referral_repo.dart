
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/services/api_service.dart';

import '../../../constants/method.dart';

class ReferralRepo{

  ApiClient apiClient;
  ReferralRepo({required this.apiClient});

  Future<dynamic>getReferralCommission(int page)async{
    String url ='${UrlContainer.baseUrl}${UrlContainer.referralCommissionEndPoint}';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<dynamic>getReferralUser(int page)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.referralUserEndPoint}';
    final response = await  apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }

}