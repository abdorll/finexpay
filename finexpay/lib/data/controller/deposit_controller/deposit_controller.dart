
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/deposit/DepositResponseModel.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/deposit_repo/deposit_repo.dart';

class DepositController extends GetxController {

  DepositRepo repo;
  DepositController({required this.repo});
  bool isLoading=false;

  List<DepositModel>depositList=[];
  List<Crypto> cryptoCurrencyList = [];
  String? nextPageUrl='';
  String selectedCrypto ='';
  String? cryptoImagePath ='';
  String trx='';
  TextEditingController trxController=TextEditingController();

  int page=0;

  initData()async{
    isLoading=true;
    update();
    cryptoCurrencyList.clear();
    cryptoCurrencyList.insert(0, Crypto(id: -1,name: MyStrings.selectOne,code: MyStrings.selectOne,symbol: '',rate: '',dcFixed: '',dcPercent: '',wcFixed: '',wcPercent: '',status: '',image: '',createdAt: '',updatedAt: ''));
    selectedCrypto = cryptoCurrencyList[0].code.toString();
    await fetchNewList();
    isLoading=false;
    update();
  }




  Future<void> fetchNewList() async{
    page=page+1;
    if(page==1){
      cryptoCurrencyList.clear();
      cryptoCurrencyList.insert(0, Crypto(id: -1,name: MyStrings.selectOne,code: MyStrings.selectOne,symbol: '',rate: '',dcFixed: '',dcPercent: '',wcFixed: '',wcPercent: '',status: '',image: '',createdAt: '',updatedAt: ''));
      depositList.clear();
    }
    ResponseModel response = await repo.loadAllDepositHistory(page,trxController.text.toString(),cryptoId);
    if(response.statusCode==200){
      DepositResponseModel model=DepositResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        cryptoImagePath='${UrlContainer.baseUrl}${model.mainDepositModel?.cryptoImagePath}/';
        nextPageUrl=model.mainDepositModel?.deposits?.nextPageUrl;
        List<DepositModel>?tempDepositList=model.mainDepositModel?.deposits?.data;
        List<Crypto>?tempCryptoList=model.mainDepositModel?.cryptos;
        if(page==1&&tempCryptoList!=null&&tempCryptoList.isNotEmpty){
          cryptoCurrencyList.addAll(tempCryptoList);
        }
        if(tempDepositList !=null && tempDepositList.isNotEmpty){
          depositList.addAll(tempDepositList);
        }
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg:[], isError:true);
      }
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
    }
    update();
    return;

  }

  int cryptoId=-1;
  void initCryptoIndex() {
    int index = cryptoCurrencyList
        .indexWhere((element) => element.code == selectedCrypto);
    cryptoId = cryptoCurrencyList[index].id?.toInt() ?? -1;
  }

  bool hasNext(){
    return nextPageUrl!=null && nextPageUrl!.isNotEmpty?true:false;
  }

  bool filterLoading=false;
  Future<void> filterData()async{
    page=0;
    expandIndex=-1;
    filterLoading=true;
    update();
    depositList.clear();
    await fetchNewList();
    filterLoading=false;
    update();
    return;
  }

  changeCurrency(String value) {
    selectedCrypto = value;
   update();
   initCryptoIndex();
  }

  void clearData(){
    page=0;
    nextPageUrl='';
    depositList.clear();
    isLoading=false;
  }

  int expandIndex = -1;
  void changeExpandIndex(int index){
    expandIndex = index;
    update();
  }


}