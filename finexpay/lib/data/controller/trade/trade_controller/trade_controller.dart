import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/trade/TradeResponseModel.dart';

import '../../../../constants/my_strings.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../model/global/response_model/response_model.dart';
import '../../../repo/trade/trade_repo/trade_repo.dart';

class TradeController extends GetxController {
  TradeRepo repo;

  TradeController({required this.repo});

  bool isRunningSelected = true;
  bool isRunningLoading = true;
  String? runningNextUrl;
  String? completedNextUrl;
  List<RunningTradeData> runningTradeList = [];
  List<CompletedTradeData> completeTradeList = [];
  bool isLoading = true;
  int runningIndex = 0;
  int completedIndex = 0;
  String? cryptoImagePath = '';

  Future<void> loadInitialRunningTrade() async {
    runningIndex = runningIndex + 1;
    if (runningIndex == 1) {
      isLoading = true;
      runningTradeList.clear();
      update();
    }

    ResponseModel response = await repo.getTradeData(runningIndex);

    if (response.statusCode == 200) {
      TradeResponseModel model =
          TradeResponseModel.fromJson(jsonDecode(response.responseJson));

      cryptoImagePath = model.data?.gatewayImagePath;
      runningNextUrl = model.data?.runningTrades?.nextPageUrl;

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<RunningTradeData>? tempRunningList =
            model.data?.runningTrades?.data;
        if (tempRunningList != null && tempRunningList.isNotEmpty) {
          runningTradeList.addAll(tempRunningList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [''], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }

    if (runningIndex == 1) {
      isLoading = false;
    }
    update();
  }

  Future<void> loadCompleteTrade() async {
    completedIndex = completedIndex + 1;
    if (completedIndex == 1) {
      isLoading = true;
      completeTradeList.clear();
      update();
    }

    ResponseModel response = await repo.getTradeData(completedIndex);

    if (response.statusCode == 200) {
      TradeResponseModel model =
          TradeResponseModel.fromJson(jsonDecode(response.responseJson));
      cryptoImagePath = model.data?.gatewayImagePath;
      completedNextUrl = model.data?.runningTrades?.nextPageUrl;
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<CompletedTradeData>? tempCompletedList =
            model.data?.completedTrades?.data;
        if (tempCompletedList != null && tempCompletedList.isNotEmpty) {
          completeTradeList.addAll(tempCompletedList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [''], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }

    if (completedIndex == 1) {
      isLoading = false;
    }
    update();
  }

  bool hasNext({bool isRunning = true}) {
    if (isRunning) {
      return runningNextUrl == null
          ? false
          : runningNextUrl!.isEmpty
              ? false
              : true;
    } else {
      return completedNextUrl == null
          ? false
          : completedNextUrl!.isEmpty
              ? false
              : true;
    }
  }

  void changeTabMenu() async{
    isLoading=true;
    isRunningSelected = !isRunningSelected;
    runningIndex = 0;
    completedIndex = 0;
    runningTradeList.clear();
    completeTradeList.clear();
    await checkAndLoadData();
    isLoading=false;
    update();
  }

  Future<void> checkAndLoadData()async{
    if(isRunningSelected){
      await loadInitialRunningTrade();
      return;
    }else{
      await loadCompleteTrade();
      return;
    }
  }

  String getUsername(int index, {bool isRunning = true}) {
    String userId = repo.apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.userIdKey) ??
        '-1';
    if (isRunning) {
      String buyerId = runningTradeList[index].buyerId.toString();
      if (userId == buyerId) {
        return runningTradeList[index].seller?.username ?? '';
      } else {
        return runningTradeList[index].buyer?.username ?? '';
      }
    } else {
      String buyerId = completeTradeList[index].buyerId.toString();
      if (userId == buyerId) {
        return completeTradeList[index].seller?.username ?? '';
      } else {
        return completeTradeList[index].buyer?.username ?? '';
      }
    }
  }
  String getUserImage(int index, {bool isRunning = true}) {
    String userId = repo.apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.userIdKey) ??
        '-1';
    if (isRunning) {
      String buyerId = runningTradeList[index].buyerId.toString();
      if (userId == buyerId) {
        return runningTradeList[index].seller?.image !=null ?'${UrlContainer.baseUrl}"assets/images/user/profile/${runningTradeList[index].seller?.image ?? ' '}':MyImages.defaultAvatar;
      } else {
        return runningTradeList[index].buyer?.image !=null ? '${UrlContainer.baseUrl}"assets/images/user/profile/${runningTradeList[index].buyer?.image ?? ''}':MyImages.defaultAvatar;
      }
    } else {
      String buyerId = completeTradeList[index].buyerId.toString();
      if (userId == buyerId) {
        return completeTradeList[index].seller?.image!=null?'${UrlContainer.baseUrl}"assets/images/user/profile/${completeTradeList[index].seller?.image ?? ''}':MyImages.defaultAvatar;
      } else {
        return completeTradeList[index].buyer?.image!=null?'${UrlContainer.baseUrl}"assets/images/user/profile/${completeTradeList[index].buyer?.image ?? ''}':MyImages.defaultAvatar;
      }
    }
  }

  String getTrxType(int index, {bool isRunning = true}) {
    String userId = repo.apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.userIdKey) ??
        '-1';
    String buyerId = isRunning
        ? runningTradeList[index].buyerId.toString()
        : completeTradeList[index].buyerId.toString();

    if (buyerId == userId) {
      return MyStrings.buy;
    } else {
      return MyStrings.sell;
    }
  }

  String getStatus(int index, {bool isRunning = true}) {
    String status = isRunning
        ? runningTradeList[index].status.toString()
        : completeTradeList[index].status.toString();
    return status == '0'
        ? MyStrings.escrowFunded
        : status == '9'
            ? MyStrings.canceled
            : status == '2'
                ? MyStrings.buyerPaid
                : status == '8'
                    ? MyStrings.reported
                    : status == '1'
                        ? MyStrings.completed
                        : '';
  }

  Color getStatusColor(int index, {bool isRunning = true}) {
    String status = isRunning
        ? runningTradeList[index].status.toString()
        : completeTradeList[index].status.toString();
    return status == '0'
        ? MyColor.primaryColor
        : status == '9'
            ? MyColor.redCancelTextColor
            : status == '2'
                ? MyColor.secondaryColor
                : status == '8'
                    ? MyColor.closeRedColor
                    : status == '1'
                        ? MyColor.greenSuccessColor
                        : MyColor.primaryColor;
  }
}
