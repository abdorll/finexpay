
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/withdraw/WithdrawHistoryResponseModel.dart';
import 'package:local_coin/data/repo/withdraw/withdraw_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class WithdrawHistoryController extends GetxController {

  WithdrawRepo repo;
  WithdrawHistoryController({required this.repo});
  bool isLoading=false;

  List<WithdrawModel>withdrawList=[];
  List<Crypto> cryptoCurrencyList = [];
  String? nextPageUrl='';
  String selectedCrypto ='';
  String? cryptoImagePath ='';
  String trx='';
  TextEditingController trxController=TextEditingController();

  int page=0;

  initData()async{
    page=0;
    isLoading=true;
    update();
    cryptoCurrencyList.insert(0, Crypto(id: -1,name: MyStrings.selectOne,code: MyStrings.selectOne,symbol: '',rate: '',depositChargeFixed: '',depositChargePercent: '',withdrawChargeFixed: '',withdrawChargePercent: '',status: '',image: '',createdAt: '',updatedAt: ''));
    selectedCrypto = cryptoCurrencyList[0].code.toString();
    await fetchNewList();
    isLoading=false;
    update();
  }

  Future<void> fetchNewList() async{
    page=page+1;
    ResponseModel response = await repo.loadAllDepositHistory(page,trxController.text.toString(),cryptoId);
    if(response.statusCode==200){
     WithdrawHistoryResponseModel model = WithdrawHistoryResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        cryptoImagePath='${UrlContainer.baseUrl}${model.data?.cryptoImagePath}/';
        nextPageUrl=model.data?.withdrawals?.nextPageUrl;
        List<WithdrawModel>?tempWithdrawList=model.data?.withdrawals?.data;
        if(page==1){
          withdrawList.clear();
          List<Crypto>? tempList = model.data?.cryptos;
          if (tempList != null && tempList.isNotEmpty) {
            cryptoCurrencyList.clear();
            cryptoCurrencyList.addAll(tempList);
            cryptoCurrencyList.insert(0, Crypto(id: -1,name: MyStrings.selectOne,code: MyStrings.selectOne,symbol: '',rate: '',depositChargeFixed: '',depositChargePercent: '',withdrawChargeFixed: '',withdrawChargePercent: '',status: '',image: '',createdAt: '',updatedAt: ''));
          }
        }
        if(tempWithdrawList !=null && tempWithdrawList.isNotEmpty){
          withdrawList.addAll(tempWithdrawList);
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
    return nextPageUrl!=null && nextPageUrl!.isNotEmpty && nextPageUrl.toString().toLowerCase()!='null'?true:false;
  }

  bool filterLoading=false;
  Future<void> filterData()async{
    expandIndex=-1;
    page=0;
    filterLoading=true;
    update();
    withdrawList.clear();
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
    expandIndex=-1;
    page=0;
    nextPageUrl='';
    withdrawList.clear();
    isLoading=false;
  }

  int expandIndex = -1;
  void changeExpandIndex(int index){
    expandIndex = index;
    update();
  }

  String getStatus(String status){
    return  status=='1'?MyStrings.success:status=='2'?MyStrings.pending:status=='3'?MyStrings.rejected:'';
  }

  Color getBgColor(String status){
    return status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.primaryColor100:status=='3'?MyColor.redCancelTextColor:MyColor.primaryColor100;
  }

}