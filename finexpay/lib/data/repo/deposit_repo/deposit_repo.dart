
import 'package:local_coin/constants/method.dart';

import '../../../core/utils/url_container.dart';
import '../../services/api_service.dart';



class DepositRepo{

  DepositRepo({required this.apiClient});

  ApiClient apiClient;

  Future<dynamic> loadAllDepositHistory(int page,String trx,int cryptoId) async{
    String cryptoSt=cryptoId==-1?'':cryptoId.toString();
    String trxS=trx=='null'||trx.isEmpty?'':trx;
    String url ='${UrlContainer.baseUrl}${UrlContainer.depositHistoryEndPoint}$page&search=$trxS&crypto_id=$cryptoSt';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }
  Future<dynamic>getAllCryptoCurrencyList()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.cryptoListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }






}