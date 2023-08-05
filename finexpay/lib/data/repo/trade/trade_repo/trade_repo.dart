
import 'package:local_coin/data/services/api_service.dart';

import '../../../../constants/method.dart';
import '../../../../core/utils/url_container.dart';

class TradeRepo {

  ApiClient apiClient;
  TradeRepo({required this.apiClient});

  Future<dynamic>getTradeData(int page)async{
    String url ='${UrlContainer.baseUrl}${UrlContainer.tradeEndPoint}$page';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<dynamic>getMakeATradeData(int page,int addId)async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.newTradeResponseEndPoint}$addId?page=$page';
    final response= await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<dynamic>storeTrade(double amount,String details,int tradeId)async{
    String url ='${UrlContainer.baseUrl}${UrlContainer.storeTradeEndPoint}$tradeId';
    Map<String,dynamic>map= {
      'amount':amount.toString(),
      'details':details
    };
    final response =await apiClient.request(url,Method.postMethod,
       map
       ,passHeader: true);
    return response;
  }

  Future<dynamic>updateReview(int addId,{required String type,required String feedback,required String uid})async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.storeReviewEndPoint}/$uid';
    Map<String,String>params = {'type':type,'feedback':feedback,'uid':uid};
    final response= await apiClient.request(url, Method.postMethod,params,passHeader: true);
    return response;
  }

}