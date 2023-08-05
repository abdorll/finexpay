import 'package:local_coin/data/model/global/response_model/response_model.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../../data/services/api_service.dart';

class HomeRepo{

  ApiClient apiClient;
  HomeRepo({required this.apiClient});


  Future<ResponseModel>getData()async{
    apiClient.initToken();
    String url='${UrlContainer.baseUrl}${UrlContainer.dashboardEndpoint}';
    final response=await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }





}