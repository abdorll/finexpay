
import 'package:local_coin/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';

class AdvertisementRepo{

  ApiClient apiClient;
  AdvertisementRepo({required this.apiClient});

  Future<dynamic>getAdvertisementList(int page) async{

    String url ='${UrlContainer.baseUrl}${UrlContainer.advertisementHistoryEndPoint}?page=$page';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;

  }


  Future<dynamic>getNewAdvertisementData() async{

    String url ='${UrlContainer.baseUrl}${UrlContainer.newAdvertisementEndPoint}';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;

  }

  Future<dynamic>storeNewAdvertisement(dynamic json) async{

    String url ='${UrlContainer.baseUrl}${UrlContainer.storeAdvertisementEndPoint}';
    final response =await apiClient.request(url,Method.postMethod, json,passHeader: true);
    return response;

  }

  Future<dynamic>updateAdvertisementStatus(int id) async{
    String url ='${UrlContainer.baseUrl}${UrlContainer.updateAdvertisementStatusEndPoint}/${id}';
    final response =await apiClient.request(url,Method.postMethod, {'ad_id':'$id'},passHeader: true);
    return response;
  }


  //edit advertisement screen

  Future<dynamic>getEditAdvertisementData(int id) async{

    String url ='${UrlContainer.baseUrl}${UrlContainer.editAdvertisementEndPoint}$id';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;

  }

  Future<dynamic>updateAdvertisement(dynamic json,int advertisementId) async{
    String url ='${UrlContainer.baseUrl}${UrlContainer.storeAdvertisementEndPoint}/$advertisementId';
    final response =await apiClient.request(url,Method.postMethod, json,passHeader: true);
    return response;

  }

  Future<dynamic>getAdvertisementReviewList(int page,int adId) async{

    String url ='${UrlContainer.baseUrl}${UrlContainer.advertisementReviewEndPoint}$adId?page=$page';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;

  }


}