import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/withdraw/MainWithdrawResponseModel.dart';


import '../../../view/components/show_custom_snackbar.dart';
import '../../repo/withdraw/withdraw_repo.dart';

class WithdrawController extends GetxController {
  WithdrawRepo repo;

  WithdrawController({required this.repo});

  bool isLoading = true;
  int cryptoId = -1;
  String imagePath = '';
  double currentBalance = 0;
  double limit = 0;
  TextEditingController addressController= TextEditingController();


  Crypto? crypto = Crypto();
  MainWithdrawResponseModel mainResponseModel = MainWithdrawResponseModel();

  bool noInternet = false;
  void changeNoInternetStatus(bool status){
    noInternet=status;
    update();
  }

  void initData(int id) async {
    cryptoId = id;
    changeIsLoading(true);
    final ResponseModel response = await repo.getWithdrawData(cryptoId);

    if (response.statusCode == 200) {
      MainWithdrawResponseModel model =
          MainWithdrawResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        String cBalance=model.data?.currentBalance?.replaceAll(',', '') ?? '0';
        currentBalance = double.tryParse(cBalance)??0;
        limit = double.tryParse(model.data?.limit?.replaceAll(',', '') ?? '0')??0;
        crypto = model.data?.crypto;
        charge=model.data?.chargeMessage??'-----';
        imagePath =
            '${UrlContainer.baseUrl}${model.data?.cryptoImagePath}/${model.data?.crypto?.image}';
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
    } else {
      if(response.statusCode==503){
        changeNoInternetStatus(true);
      }
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
    changeIsLoading(false);
  }

  void changeIsLoading(bool status) {
    isLoading = status;
    update();
  }

  String depositLimit = '';
  String charge = '';
  TextEditingController amountController = TextEditingController();





  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
  }


  bool submitLoading=false;

  void requestWithdraw(String walletAddress,String withdrawAmount)async{

    if(walletAddress.isEmpty){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.emptyWalletAddressMsg], msg: [], isError: true);
      return;
    }

     if(withdrawAmount.isEmpty){
       CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.withdrawAmountError], msg: [], isError: true);
       return;
     }

    submitLoading=true;
    update();

    ResponseModel response=await repo.makeWithdrawRequest(cryptoId.toString(),walletAddress,withdrawAmount);
    if(response.statusCode==200){
      AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){

        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success??[MyStrings.withdrawRequestSubmitted], isError: false);
        addressController.text='';
        amountController.text='';
        submitLoading=false;
        withdrawCharge=00;
        update();
        Get.toNamed(RouteHelper.withdrawHistoryScreen);

      }else{
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.requestFail], msg: [], isError: true);
        submitLoading=false;
        update();
      }

    }
    else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError:true);
      submitLoading=false;
      update();
    }

  }

  dynamic withdrawCharge = 00;

  void changeCharge(double? amount) {
    amount=amount ?? 0;
    withdrawCharge = (double.parse(crypto?.wcFixed ?? '0') +
            (amount * (double.parse(crypto?.wcPercent ?? '0') / 100)))
        .toStringAsFixed(8);
    update();
  }

}
