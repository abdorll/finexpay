import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/services/api_service.dart';

import '../../../constants/method.dart';

class WalletRepo{

  ApiClient apiClient;
  WalletRepo({required this.apiClient});

  Future<dynamic>getWalletList()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.walletListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod,null,passHeader: true,);
    return response;

  }

  Future<dynamic>generateAddress(int id)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.generateCryptoWalletAddress}$id';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }

  Future<dynamic>getAddressList(int id,int page)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.walletAddressListEndpoint}$id?page=$page';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }

  Future<dynamic>getSingleWalletTrxList(int id)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.walletAddressListEndpoint}$id';
    final response = await apiClient.request(url, Method.getMethod,null, passHeader: true);
    return response;

  }



}
