
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/data/model/dashboard/DashboardResponseModel.dart';

import '../../../../view/components/show_custom_snackbar.dart';
import '../../../constants/my_strings.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/home_repo/home_repo.dart';

class HomeController extends GetxController {

  HomeRepo repo;
  HomeController({required this.repo});

  bool isLoading = true;


  List<Wallets> walletList = [];
  List<Ads>adList=[];
  List<Ads>filteredAdList=[];
  UserInfo? user = UserInfo();
  String? userImagePath = '';
  String? cryptoImagePath = '';
  String? gatewayImagePath = '';
  String? buyAdd = '0';
  String? sellAdd = '0';
  String? runningTrade = '0';
  String? completedTrade = '0';
  String? referLink = '';

  Future<dynamic> initData() async {
    isLoading=true;
    update();

    ResponseModel response = await repo.getData();

    if (response.statusCode == 200) {
      DashboardResponseModel model =
      DashboardResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        userImagePath=model.data?.userImagePath;
        cryptoImagePath=model.data?.cryptoImagePath;
        gatewayImagePath=model.data?.gatewayImagePath;
        buyAdd=model.data?.totalBuyAdd??'0';
        sellAdd=model.data?.totalSellAdd??'0';
        runningTrade=model.data?.runningTradeCount??'0';
        completedTrade=model.data?.completedTradeCount??'0';
        user=model.data?.userInfo;
        referLink=model.data?.referralLink;

        List<Wallets>? tempWalletList = model.data?.wallets;
        List<Ads>? tempAdList = model.data?.ads;

        if (tempWalletList != null && tempWalletList.isNotEmpty) {
          walletList.clear();
          walletList.addAll(tempWalletList);
        }

        if(tempAdList!=null && tempAdList.isNotEmpty){
          adList.clear();
          adList.addAll(tempAdList);
          changeTabMenu(true);
        }

      }
      else{
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }
    else {
      if(response.statusCode==503){
         changeNoInternetStatus(true);
      }
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
    }

    setNewNotification();
    isLoading=false;
    update();
    return;
  }

  bool noInternet = false;
  void changeNoInternetStatus(bool status){
    noInternet=status;
    update();
  }



  bool hasNewNotification=false;
  void setNewNotification(){
    hasNewNotification=repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.hasNewNotificationKey)??false;
  }


  void changeNewNotification(bool isChange){
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,false);
    hasNewNotification=false;
    update();
  }

  bool isBuySelected = true;
  void changeTabMenu(bool isBuy) {

      isBuySelected = isBuy;
      changeAddList();
      update();

  }

  String getImage(){
    return user?.image !=null ?'${user?.image}':MyImages.defaultAvatar;
  }


  void changeAddList(){

    String type=isBuySelected?'buy':'sell';

      List<Ads>tempAddList=[];
      for(Ads ad in adList){
        if(ad.type?.toLowerCase()==type){
          tempAddList.add(ad);
        }
      }

      filteredAdList.clear();
      filteredAdList.addAll(tempAddList);
      return;
  }
}