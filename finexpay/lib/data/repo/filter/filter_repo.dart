
import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../../data/services/api_service.dart';

class FilterRepo{

  ApiClient apiClient;
  FilterRepo({required this.apiClient});


  Future<dynamic>getAllCryptoCurrencyList()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.cryptoListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }


  Future<dynamic>getAdFilterData()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.adFilterEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }


  Future<dynamic>getAdvertisement(List<String>argument,int page)async{

    String url;
    if(argument[6].isNotEmpty){
      url='${UrlContainer.baseUrl}${UrlContainer.marketEndPoint}'
          'page=$page&crypto_id=${argument[1]}&type=${argument[0]}&country=${argument[2]}&country_code=${argument[3]}&fiat_gateway_id=${argument[4]}&fiat_id=${argument[5]}&amount=${argument[6]}';

    }else{
      url='${UrlContainer.baseUrl}${UrlContainer.marketEndPoint}'
          'page=$page&crypto_id=${argument[1]}&type=${argument[0]}&country=${argument[2]}&country_code=${argument[3]}&fiat_gateway_id=${argument[4]}&fiat_id=${argument[5]}';
    }
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }

}