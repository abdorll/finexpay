import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/repo/wallet_repo/wallet_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../../model/wallet/main_wallet_response_model/MainWalletResponseModel.dart';

class WalletController extends GetxController {

  WalletRepo repo;
  WalletController({required this.repo});

  bool walletLoading = true;
  List<Wallets> walletList = [];
  String imagePath='';


  bool noInternet = false;
  void changeNoInternetStatus(bool status){
    noInternet=status;
    update();
  }

  void initData() async {

    changeIsLoading(true);
    ResponseModel response = await repo.getWalletList();

    if (response.statusCode == 200) {
      MainWalletResponseModel model =
          MainWalletResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

        List<Wallets>? tempList = model.data?.wallets;
        imagePath=model.data?.cryptoImagePath??'';
        walletList.clear();
        if (tempList != null && tempList.isNotEmpty) {
          walletList.addAll(tempList);
        }
        changeIsLoading(false);
      }else{
        showError(model.message?.error??[MyStrings.somethingWentWrong]);
        changeIsLoading(false);
      }
    } else {
      if(response.statusCode==503){
        changeNoInternetStatus(true);
      }
      showError([response.message]);
      changeIsLoading(false);
    }
  }

  changeIsLoading(bool b) {
    walletLoading = b;
    update();
  }

  showError(List<String> message) {
    CustomSnackbar.showCustomSnackbar(
        errorList: message, msg: [], isError: true);
  }

  String getCharge(String dcFixed, String dcPercent) {

    double dFixed = double.parse(dcFixed);
    String mainFixed = dFixed > 0 ? '$dFixed + ' : '';

    return '$mainFixed$dcPercent %';
  }

}
