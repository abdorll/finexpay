

import 'package:local_coin/constants/method.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/services/api_service.dart';

class MarketplaceRepo {
  ApiClient apiClient;

  MarketplaceRepo({required this.apiClient});

  Future<dynamic> getData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.verifyEmailEndPoint}';
    ResponseModel model=await apiClient.request(url, Method.getMethod, null,passHeader: true);

    return model;
  }

  Future<dynamic>getAllCryptoCurrencyList()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.cryptoListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }


  Future<dynamic>getAdvertisement(int cryptoId,{String type='1',int page=0})async{

    if(type.toLowerCase()=='all'){
      type='';
    }

    String url='${UrlContainer.baseUrl}${UrlContainer.marketEndPoint}page=$page&crypto_id=$cryptoId&type=$type&country=all&country_code=all';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }
}