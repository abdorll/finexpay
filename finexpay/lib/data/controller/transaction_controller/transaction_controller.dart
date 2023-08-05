import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/crypto_currency_response_model/CryptoCurrencyResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/transaction_response_model/TransactionResponseModel.dart'
    as TrxModel;
import 'package:local_coin/data/repo/transaction_repo/transaction_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

class TransactionController extends GetxController {
  TransactionRepo repo;

  TransactionController({required this.repo});

  bool isLoading = true;

  List<String> transactionTypeList = [MyStrings.selectATrxType,MyStrings.plus, MyStrings.minus];
  List<Cryptos> cryptoCurrencyList = [
  (Cryptos(id: -1,name: MyStrings.selectACrypto,code: MyStrings.selectACrypto,symbol: "S",rate: "",dcFixed: "",dcPercent: "",
  wcFixed: "",wcPercent: "",status: "",image: "",createdAt: "",updatedAt: "")),
  ];
  List<TrxModel.Data> transactionList = [];
  List<TrxModel.Remarks> remarksList = [(TrxModel.Remarks(remark: MyStrings.selectARemarks))];
  int cryptoId = -1;
  String assetPath = '';
  String trxSearchTxt = '';
  String?nextPageUrl;

   TextEditingController trxController = TextEditingController();

   String selectedRemark=MyStrings.selectARemarks;
   String selectedTrxType=MyStrings.selectATrxType;
   String selectedCrypto=MyStrings.selectACrypto;



  int getIndexOfCryptoCurrency(){
    int cryptoIndex=cryptoCurrencyList.indexWhere((element) => element.code==selectedCrypto);
    cryptoId=cryptoCurrencyList[cryptoIndex].id?.toInt()??-1;
    return cryptoIndex;
  }



  void initialSelectedValue()async{

     page=0;
     selectedRemark=MyStrings.selectARemarks;
     selectedTrxType=MyStrings.selectATrxType;
     selectedCrypto=MyStrings.selectACrypto;


    transactionList.clear();
    isLoading=true;
    update();
    await loadInitialTransaction();
    isLoading=false;
    update();

  }


  void initData() async {
    await loadAllCryptoCurrencies();
    await loadInitialTransaction();
    isLoading=false;
    update();
  }

  void loadPaginationData()async{
    await loadInitialTransaction();
    update();
  }


  Future<void> loadInitialTransaction() async {
    page=page+1;
    if(page==1){
      remarksList.clear();
      remarksList.insert(0, TrxModel.Remarks(remark: MyStrings.selectARemarks));
      transactionList.clear();
    }
    final ResponseModel response = await repo.getTransactionList(page,cryptoId,type: selectedTrxType.toLowerCase(),remark: selectedRemark,searchTxt: trxSearchTxt);

    if (response.statusCode == 200) {
      TrxModel.TransactionResponseModel model =
          TrxModel.TransactionResponseModel.fromJson(
              jsonDecode(response.responseJson));

      nextPageUrl=model.data?.transactions?.nextPageUrl;
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<TrxModel.Data>? tempList = model.data?.transactions?.data;
        if(page==1){
          List<TrxModel.Remarks>? tempRemarksList = model.data?.remarks;
          assetPath=model.data?.assetPath??'';
          if (tempRemarksList != null && tempRemarksList.isNotEmpty) {
            remarksList.addAll(tempRemarksList);
            //changeSelectedRemark(remarksList[0].remark??'');
          }
        }
        if (tempList != null && tempList.isNotEmpty) {
          transactionList.addAll(tempList);
        }
      } else {

        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
      return;
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
      return;
    }
  }

  Future<void> loadAllCryptoCurrencies() async {
    final ResponseModel response = await repo.getAllCryptoCurrencyList();

    if (response.statusCode == 200) {
      CryptoCurrencyResponseModel model = CryptoCurrencyResponseModel.fromJson(
          jsonDecode(response.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Cryptos>? tempList = model.data?.cryptos;
        if (tempList != null && tempList.isNotEmpty) {
          cryptoCurrencyList.clear();
          cryptoCurrencyList.addAll(tempList);
          cryptoCurrencyList.insert(0, Cryptos(id: -1,name: MyStrings.selectACrypto,code: MyStrings.selectACrypto,symbol: "S",rate: "",dcFixed: "",dcPercent: "",
          wcFixed: "",wcPercent: "",status: "",image: "",createdAt: "",updatedAt: ""));
          selectedCrypto=cryptoCurrencyList[0].code!;
         // changeSelectedCrypto(cryptoCurrencyList[0].code??'');
        }
      }
      return;
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
      return;
    }
  }

  void changeSelectedRemark(String remarks){
    selectedRemark=remarks;
    update();
  }

  void changeSelectedTrxType(String trxType){
    selectedTrxType=trxType;
    update();
  }

  void changeSelectedCrypto(String value){
    selectedCrypto=value;
    getIndexOfCryptoCurrency();
    update();
  }

  int page=0;
  bool filterLoading=false;
 Future<void> filterData()async{
    trxSearchTxt=trxController.text;
    page=0;
    expandedIndex=-1;
   getIndexOfCryptoCurrency();
    filterLoading=true;
    update();
    await loadInitialTransaction();
    filterLoading=false;
    update();

  }

  bool hasNext(){
    return nextPageUrl !=null && nextPageUrl!.isNotEmpty && nextPageUrl!='null'?true:false;
  }


  int expandedIndex=-1;
  void changeListExpandedIndex(int exIndex) {
    exIndex==expandedIndex? expandedIndex=-1: expandedIndex=exIndex;
    update();
  }


  String getAfterCharge(double? amount, double? charge) {

    amount = amount ?? 0;
    charge = charge ?? 0;

    double summation = amount - charge;
    return summation.toStringAsFixed(8);

  }

  String getStatus(String status) {
    return status=='1'?MyStrings.success:status=='2'?MyStrings.pending:status=='3'?MyStrings.cancel_:'';
  }

}
