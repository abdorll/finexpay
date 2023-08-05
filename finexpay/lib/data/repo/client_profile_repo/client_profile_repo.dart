
import 'package:local_coin/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';

class ClientProfileRepo{
  ApiClient apiClient;
  ClientProfileRepo({required this.apiClient});

  Future<dynamic>getClientProfileData(String username,int page)async{
      String url='${UrlContainer.baseUrl}${UrlContainer.publicProfileEndpoint}$username?page=$page';
      final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
      return response;
  }

}