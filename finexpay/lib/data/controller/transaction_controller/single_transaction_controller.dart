import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/crypto_currency_response_model/CryptoCurrencyResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/transaction_response_model/TransactionResponseModel.dart'
    as TrxModel;
import 'package:local_coin/data/repo/transaction_repo/transaction_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

class SingleTransactionController extends GetxController {
  TransactionRepo repo;

  SingleTransactionController({required this.repo});

  bool isLoading = true;

  List<Cryptos> cryptoCurrencyList = [];
  List<TrxModel.Data> transactionList = [];
  List<TrxModel.Remarks> remarksList = [];
  String? nextPageUrl;
  int currentPage=0;
  int cryptoId = -1;
  String assetPath = '';

String selectedCrypto='';






  int getIndexOfCryptoCurrency(){
    int index=cryptoCurrencyList.indexWhere((element) => element.code==selectedCrypto);
    cryptoId=cryptoCurrencyList[index].id?.toInt()??-1;
    return index;
  }

  void initData(int id) async {
    cryptoId = id;
    await loadInitialTransaction();
  }

  Future<void> loadInitialTransaction() async {

    currentPage=currentPage+1;
    if(currentPage==1){
      transactionList.clear();
      isLoading=true;
      update();
    }

    final ResponseModel response = await repo.getSingleTransactionList(cryptoId,currentPage);

    if (response.statusCode == 200) {
      TrxModel.TransactionResponseModel model =
          TrxModel.TransactionResponseModel.fromJson(
              jsonDecode(response.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<TrxModel.Data>? tempList = model.data?.transactions?.data;
        nextPageUrl=model.data?.transactions?.nextPageUrl;
        assetPath=model.data?.assetPath??'';
        if (tempList != null && tempList.isNotEmpty) {
          transactionList.addAll(tempList);
        }
      }else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
    if(currentPage==1){
      isLoading=false;
    }
    update();
    return;
  }


  String getStatus(String status) {
    return status=='1'?'Success':status=='2'?'Pending':status=='3'?'Cancel':'Unknown';
  }

  int expandedIndex=-1;
  void changeListExpandedIndex(int index) {
    index==expandedIndex? expandedIndex=-1: expandedIndex=index;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty? true : false ;
  }



}
