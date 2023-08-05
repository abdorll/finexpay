
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';

class TransactionRepo{
  ApiClient apiClient;

  TransactionRepo({required this.apiClient});

  Future<dynamic>getAllCryptoCurrencyList()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.cryptoListEndpoint}';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }

  Future<dynamic>getTransactionList(int page,int cryptoId,{String type='',String searchTxt='',String remark=''})async{


    if(type.toLowerCase()==MyStrings.selectATrxType.toLowerCase()||(type.toLowerCase()!='plus'&&type.toLowerCase()!='minus')){
      type='';
    }

    if(remark.isEmpty||remark.toLowerCase()==MyStrings.selectARemarks.toLowerCase()){
      remark = '';
    }

    late String url;
    if(cryptoId<0){
      url='${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}?page=$page&crypto_id=&type=$type&search=$searchTxt&remark=$remark';
    }else{
      url='${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}?page=$page&crypto_id=$cryptoId&type=$type&search=$searchTxt&remark=$remark';
    }
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;

  }

  Future<dynamic>getSingleTransactionList(int cryptoId,int currentPage)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}?page=$currentPage&crypto_id=$cryptoId&type=&search=&remark=';
    final response = await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }
}