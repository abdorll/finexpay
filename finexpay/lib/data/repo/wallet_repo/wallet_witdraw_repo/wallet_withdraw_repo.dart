

import 'package:local_coin/data/services/api_service.dart';

import '../../../../constants/method.dart';
import '../../../../core/utils/url_container.dart';

class WalletWithdrawRepo{

  ApiClient apiClient;
  WalletWithdrawRepo({required this.apiClient});

  Future<dynamic>makeWithdrawRequest(double amount,String walletAddress)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.walletListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;

  }

  Future<dynamic>getWithdrawHistory(int walletId)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.walletListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;

  }

}