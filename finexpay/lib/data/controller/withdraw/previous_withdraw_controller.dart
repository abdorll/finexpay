import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/withdraw/PreviousWithdrawalsResponseModel.dart';
import 'package:local_coin/data/repo/withdraw/withdraw_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

class PreviousWithdrawController extends GetxController {
  WithdrawRepo repo;

  PreviousWithdrawController({required this.repo});

  bool isLoading = true;
  int page = 0;
  int cryptoId = 0;
  List<Data> withdrawList = [];
  String imagePath = '';
  String cryptoName = '';
  String? nextPageUrl;

  void initData() async {
    page=page+1;
    if(page==1){
      withdrawList.clear();
      isLoading=true;
      update();
    }
    ResponseModel response = await repo.getPreviousWithdrawData(page, cryptoId);
    if (response.statusCode == 200) {
        PreviousWithdrawalsResponseModel model =
            PreviousWithdrawalsResponseModel.fromJson(
                jsonDecode(response.responseJson));

        nextPageUrl=model.data?.pastWithdrawals?.nextPageUrl;
        if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

          List<Data>? tempWithdrawList = model.data?.pastWithdrawals?.data;

          if (tempWithdrawList != null && tempWithdrawList.isNotEmpty) {
            imagePath =
            '${UrlContainer.baseUrl}${model.data?.assetPath}/${tempWithdrawList[0].crypto?.image}';
            cryptoName = tempWithdrawList[0].crypto?.code ?? '';
            withdrawList.addAll(tempWithdrawList);
          }

        }else{
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
        }

    } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: [response.message], msg: [], isError: true);

    }
    if(page==1){
      isLoading = false;
    }
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty? true: false ;
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

  Color getStatusColor(String status){
    return status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.primaryColor:status=='3'?MyColor.redCancelTextColor:MyColor.secondaryColor;
  }

}
