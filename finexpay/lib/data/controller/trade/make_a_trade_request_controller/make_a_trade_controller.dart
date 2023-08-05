import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/trade/MakeATradeResponseModel.dart';
import 'package:local_coin/data/repo/trade/trade_repo/trade_repo.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../model/global/response_model/response_model.dart';


class MakeATradeController extends GetxController{

  TradeRepo repo;
  MakeATradeController({required this.repo});


  int tradeId=-1;
  int page=0;
  bool isLoading=true;
  String? nextPageUrl;
  String? imagePath = '';

  String rate ='' ;
  String avgSpeed ='' ;
  String maxLimit ='' ;
  String titleOne ='' ;
  String titleTwo ='' ;
  String heading ='' ;
  String positiveReview = '0';
  String negativeReview = '0';
  String allReview = '0';

  TextEditingController payController = TextEditingController();
  TextEditingController receiveController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  double cryptoRate = 0 ;



  bool showMin=false;
  bool showMax = false;
  String limitMessage = '';
  changePayTextField(String amount)
  {
    showMin=false;
    showMax=false;
    update();
    double mAmount=double.tryParse(amount)??0;
    double myRate= double.tryParse(rate)??0;
    double cryptoAmount = mAmount/myRate;


    //show min amount
    double min = double.tryParse(ad.min??'0')??0;
    if(mAmount<min){
      receiveController.text='0';
      showMin=true;
      limitMessage = '${MyStrings.minimumLimitIs.tr} : $min ${ad.fiat?.code??''}';
      update();
      return;
    }
    double max = double.tryParse(maxLimit)??0;
    if(mAmount>max){
      showMax=true;
      limitMessage = '${MyStrings.maximumLimitIs.tr} : $maxLimit ${ad.fiat?.code??''}';
      receiveController.text='0';
      update();
      return;
    }
    receiveController.text=CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(cryptoAmount.toString(),precision: 8);
  }

  changeReceiveTextField(String amount)
  {
    showMin=false;
    showMax=false;
    update();
    double mAmount=double.tryParse(amount)??0;
    double myRate= double.tryParse(rate)??0;
    double fiatAmount = myRate*mAmount;
    double min = double.tryParse(ad.min??'0')??0;
    if(fiatAmount<min){
      payController.text='0';
      showMin=true;
      limitMessage = '${MyStrings.minimumLimitIs.tr} : $min ${ad.fiat?.code??''}';
      update();
      return;
    }
    double max = double.tryParse(maxLimit)??0;
    if(fiatAmount>max){
      payController.text='0';
      showMax=true;
      limitMessage = '${MyStrings.maximumLimitIs.tr} : $maxLimit ${ad.fiat?.code??''}';
      update();
      return;
    }
    payController.text=CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(fiatAmount.toString(),precision: 8);
  }


  Ad ad=Ad();
  List<AllReviews>reviewList=[];

  Future<void> loadData() async {

    page=page+1;
      isLoading=true;
      reviewList.clear();
      update();

    final ResponseModel response = await repo.getMakeATradeData(page, tradeId);
    if (response.statusCode == 200) {

     MakeATradeResponseModel model =
     MakeATradeResponseModel.fromJson(
          jsonDecode(response.responseJson));


      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        
        rate=model.data?.rate.toString()??'0';
        avgSpeed=model.data?.avgSpeed.toString()??'0';
        maxLimit = CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(model.data?.maxLimit.toString()??'0');
        titleOne = model.data?.titleOne??'';
        titleTwo = model.data?.titleTwo??'';
        heading  = model.data?.heading??'';

        positiveReview = model.data?.positiveReviewCount.toString()??'0';
        negativeReview = model.data?.negativeReviewCount.toString()??'0';
        allReview = model.data?.allReviewCount.toString()??'0';

        ad=model.data?.ad??Ad();
        setCryptoRate();

        List<AllReviews>? tempList = model.data?.allReviews;
        nextPageUrl=model.data?.nextPageUrl;
        if (tempList != null && tempList.isNotEmpty) {
          reviewList.addAll(tempList);
        }
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

    isLoading=false;
    update();
    return;
  }

  bool submitLoading = false ;
  void submitTradeRequest()async{
    String payAmount = payController.text.toString();
    String message  = messageController.text.toString();
    if(payAmount.isEmpty || showMax || showMin){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.plsEnterAValidAmount], msg: [], isError: true);
      update();
      return;
    }else if(message.isEmpty){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.plsEnterYourMessage], msg: [], isError: true);
      update();
      return;
    }else{

      submitLoading=true;
      update();

      double amount = double.tryParse(payAmount)??0;
      ResponseModel response = await repo.storeTrade(amount, message, tradeId);

      if(response.statusCode == 200){
          AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
          if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
            payController.text='';
            receiveController.text='';
            messageController.text='';
            CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success??[MyStrings.success], isError: false);
            var json=jsonDecode(response.responseJson);
            String trxId = json['data']['trade_uid'].toString();
            Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: trxId);
          }
          else{
            CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError:true);
          }
      }
      else{
           CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      }

      submitLoading=false;
      update();

    }
  }

  bool hasNext(){
    return nextPageUrl!=null && nextPageUrl!.isNotEmpty && nextPageUrl!.toLowerCase()!='null'?true:false;
  }

  loadPaginationData()async{
    page=page+1;
    final ResponseModel response = await repo.getMakeATradeData(page, tradeId);
    if (response.statusCode == 200) {
      MakeATradeResponseModel model =
      MakeATradeResponseModel.fromJson(
          jsonDecode(response.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

        List<AllReviews>? tempReviewList = model.data?.allReviews;
        nextPageUrl=model.data?.nextPageUrl;
        if (tempReviewList != null && tempReviewList.isNotEmpty) {
          reviewList.addAll(tempReviewList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }

    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);

    }
    update();
    return;
  }

  setCryptoRate(){
      cryptoRate = double.tryParse(ad.crypto?.rate??'0')??0;
  }

  TextEditingController reviewFeedbackController = TextEditingController();
  bool isUpdateReviewPositive=false;
  updateReviewType(bool type){
    isUpdateReviewPositive=type;
    update();
  }

  bool isReviewUpdating=false;
  Future<void>updateReview(int index)async{
    String feedback = reviewFeedbackController.text.toString();
    if(feedback.isEmpty){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.reviewFieldEmpty], msg: [], isError: true);
      return ;
    }

    isReviewUpdating=true;
    update();
    ResponseModel response = await repo.updateReview(reviewList[index].id??-1, type: isUpdateReviewPositive?'1':'0', feedback: feedback,uid:reviewList[index].tradeUid??'');
    if(response.statusCode==200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        reviewList[index] = reviewList[index].copyWith(type:isUpdateReviewPositive?'1':'0',feedback: feedback );
        Get.back();
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success??[], isError: false);
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.requestFail], msg: [], isError: true);
      }
    }
    else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      return ;
    }

    isReviewUpdating=false;
    reviewFeedbackController.text='';
    update();
    return ;


  }

  bool noInternet = false;
  void changeNoInternetStatus(bool status){
    noInternet=status;
    update();
  }


  IconData getIcon(String status) {
    return status == '1' ? Icons.done : Icons.clear;
  }
  String getProfileImage() {
    return ad.user?.image!=null?'${UrlContainer.baseUrl}${'assets/images/user/profile/'}${ad.user?.image}':MyImages.defaultAvatar;
  }

  Color getIconColor(String status) {
    return status == '1'
        ? MyColor.greenSuccessColor
        : MyColor.redCancelTextColor;
  }

}
