

import 'package:local_coin/constants/method.dart';

import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';


class WithdrawRepo{
  ApiClient apiClient;

  WithdrawRepo({required this.apiClient});

  Future<dynamic>getWithdrawData(int cryptoId)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.withdrawRequestUrl}$cryptoId';
    ResponseModel model=await apiClient.request(url, Method.getMethod,null,passHeader: true);
    return model;
  }

  Future<dynamic>makeWithdrawRequest(String cryptoId,String walletAddress,String amount) async{
    String url='${UrlContainer.baseUrl}${UrlContainer.submitWithdrawRequestUrl}';

    Map<String,dynamic>params={
      'crypto_id':cryptoId,
      'wallet_address':walletAddress,
      'amount':amount,
    };

    final ResponseModel model=await apiClient.request(url, Method.postMethod, params,passHeader: true);
    return model;

  }

  Future<dynamic>getPreviousWithdrawData(int page,int cryptoId)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.previousWithdrawUrl}$cryptoId?page=$page';
    ResponseModel model=await apiClient.request(url, Method.getMethod,null,passHeader: true);
    return model;
  }


  Future<dynamic> loadAllDepositHistory(int page,String trx,int cryptoId) async{
    String cryptoSt=cryptoId==-1?'':cryptoId.toString();
    String trxS=trx=='null'||trx.isEmpty?'':trx;
    String url ='${UrlContainer.baseUrl}${UrlContainer.allWithdrawHistoryEndPoint}$page&search=$trxS&crypto_id=$cryptoSt';
    final response =await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }


  Future<dynamic>getAllCryptoCurrencyList()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.cryptoListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }

}

