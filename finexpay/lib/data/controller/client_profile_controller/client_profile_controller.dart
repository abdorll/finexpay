import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/public_profile/PublicProfileResponseModel.dart';
import 'package:local_coin/data/repo/client_profile_repo/client_profile_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../../constants/my_strings.dart';

class ClientProfileController extends GetxController  {
  ClientProfileRepo repo;

  String imageStaticUrl = '';
  bool isProfileComplete = false;

  ClientProfileController({required this.repo});

  String? userImagePath = '';
  String? gatewayImagePath = '';
  bool isLoading = true;
  String? positiveReviewCount = '0';
  String? negativeReviewCount = '0';
  String? totalReviewCount = '0';

  User? user = User();
  List<SellAds> sellAddList = [];
  List<BuyAds> buyAddList = [];

  String userName = '';

  Future<void> initData(String username) async {
    userName = username;
    isLoading = true;
    update();
    ResponseModel response = await repo.getClientProfileData(userName,1);
    if (response.statusCode == 200) {
      PublicProfileResponseModel profileResponseModel =
          PublicProfileResponseModel.fromJson(
              jsonDecode(response.responseJson));
      if (profileResponseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        loadData(profileResponseModel);
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: profileResponseModel.message?.error ??
                [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
    isLoading = false;
    update();
  }

  void loadData(PublicProfileResponseModel profileResponseModel) {
    buyAddList.clear();
    user = profileResponseModel.data?.user;
    totalReviewCount = profileResponseModel.data?.allReviewCount;
    negativeReviewCount = profileResponseModel.data?.negativeReviewCount;
    positiveReviewCount = profileResponseModel.data?.positiveReviewCount;
    gatewayImagePath = profileResponseModel.data?.gatewayImagePath;
    userImagePath = profileResponseModel.data?.userImagePath;

    buyAddNextPageUrl = profileResponseModel.data?.buyAdsNextPageUrl;
    sellAddNextPageUrl = profileResponseModel.data?.sellAdsNextPageUrl;
    sellIndex = 1;
    buyIndex = 1;

    List<BuyAds>? tempBuyAddList = profileResponseModel.data?.buyAds;
    List<SellAds>? tempSellAddList = profileResponseModel.data?.sellAds;
    if (tempBuyAddList != null && tempBuyAddList.isNotEmpty) {
      buyAddList.clear();
      buyAddList.addAll(tempBuyAddList);
    }

    if (tempSellAddList != null && tempSellAddList.isNotEmpty) {
      sellAddList.clear();
      sellAddList.addAll(tempSellAddList);
    }

  }


  loadPaginationData()async{
    isBuyAddSelected?buyIndex=buyIndex+1:sellIndex=sellIndex+1;
    ResponseModel response = await repo.getClientProfileData(userName, isBuyAddSelected?buyIndex:sellIndex);
    if (response.statusCode == 200) {
      PublicProfileResponseModel profileResponseModel =
      PublicProfileResponseModel.fromJson(
          jsonDecode(response.responseJson));
      if (profileResponseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        // if successful then update the index number
        if(isBuyAddSelected){
          sellIndex=sellIndex++;
        }else{
          buyIndex=buyIndex++;
        }

        buyAddNextPageUrl = profileResponseModel.data?.buyAdsNextPageUrl;
        sellAddNextPageUrl = profileResponseModel.data?.sellAdsNextPageUrl;
        sellIndex = 1;
        buyIndex = 1;

        List<BuyAds>? tempBuyAddList = profileResponseModel.data?.buyAds;
        List<SellAds>? tempSellAddList = profileResponseModel.data?.sellAds;
        if (tempBuyAddList != null && tempBuyAddList.isNotEmpty) {
          buyAddList.addAll(tempBuyAddList);
        }

        if (tempSellAddList != null && tempSellAddList.isNotEmpty) {
          sellAddList.addAll(tempSellAddList);
        }
        update();
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: profileResponseModel.message?.error ??
                [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
  }

  String? buyAddNextPageUrl;
  String? sellAddNextPageUrl;
  bool hasNext() {
    if(isBuyAddSelected){
      return buyAddNextPageUrl !=null && buyAddNextPageUrl!.isNotEmpty?true:false;
    }else{
      return sellAddNextPageUrl !=null && sellAddNextPageUrl!.isNotEmpty?true:false;
    }
  }

  bool isBuyAddSelected = true;
  int buyIndex=0;
  int sellIndex=0;

  void changeTabMenu() {
    isBuyAddSelected = !isBuyAddSelected;
    update();
  }




  Widget getIcon(String status) {
    return SvgPicture.asset( status == '1' ? MyIcons.completedTradeIcon : MyImages.errorImage,color:status == '1'
    ? MyColor.greenSuccessColor
        : MyColor.redCancelTextColor);
  }

  Color getIconColor(String status) {
    return status == '1'
        ? MyColor.greenSuccessColor
        : MyColor.redCancelTextColor;
  }


}
