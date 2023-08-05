
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/trade/FileChooserModel.dart';
import 'package:local_coin/data/model/trade/TradeDetailsResponseModel.dart';
import 'package:local_coin/data/repo/trade/trade_details_repo/trade_details_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RunningTradeDetailsController extends GetxController{
  TradeDetailsRepo repo;
  RunningTradeDetailsController({required this.repo});

  late String tradeNumber;


  bool isLoading=true;
  String? nextPageUrl;
  String? imagePath = '';
  String? chatFilePath = '';
  String? userImagePath = '';
  String? adminImagePath = '';
  String? chatPermission = '';
  String? buyerHeading = '';
  String? sellerHeading = '';
  int page = 0;
  TradeDetailsResponseModel model=TradeDetailsResponseModel();
  bool isBuyer = false;
  List<Chats>chatList=[];
  TextEditingController chatFieldController = TextEditingController();


  Future<void> initData({bool fromChatStore=false}) async{
    if(fromChatStore==false){
      isLoading=true;
      changeRemMin(reemMinEnd: false);
      update();
    }

      ResponseModel response = await repo.getTradeDetailsData(page, tradeNumber);
      if(response.statusCode==200){
        model = TradeDetailsResponseModel.fromJson(jsonDecode(response.responseJson));

        if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()){

          chatFilePath=model.data?.chatFilePath;
          userImagePath=model.data?.userImagePath;
          adminImagePath=model.data?.faviconImagePath;
          chatPermission = model.data?.chatPermission;
          isShowReview= model.data?.reviewPermission=='1'?true:false;
          alreadyReviewed=model.data?.showReviewLink=='1'?true:false;

          List<Chats>?tempChatList=model.data?.tradeDetails?.chats;
          if(tempChatList !=null && tempChatList.isNotEmpty){
            chatList.clear();
            chatList.addAll(tempChatList);
          }
          isBuyer = model.data?.tradeDetails?.buyerId.toString()==repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIdKey)?true:false;


        } else{
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[], msg: [], isError: true);
        }

      }else{
        if(response.statusCode==503){
          noInternet=true;
          update();
        }
        CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      }

      isLoading=false;
      update();
  }


  FileChooserModel fileChooserModel=FileChooserModel(fileName: MyStrings.noFileChosen);

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);

    if (result == null) return;
     
    fileChooserModel.choosenFile = File(result.files.single.path!);
   fileChooserModel.fileName = result.files.single.name;
    update();
  }

  bool isAction=true;
  changeTabBarMenu(){
    isAction=!isAction;
    update();
  }

  bool storeChatLoading=false;
  void storeChat() async{

    String message = chatFieldController.text.toString();

    if(message.isEmpty){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.msgFieldEmptyMsg], msg: [], isError:true);
      return;
    }

    storeChatLoading=true;
    update();

    ResponseModel responseModel = await repo.storeChat(message, model.data?.tradeDetails?.id??-1,file: fileChooserModel.fileName.toLowerCase()==MyStrings.noFileChosen.toLowerCase()?null:fileChooserModel);
    if(responseModel.statusCode==200){
      AuthorizationResponseModel testModel = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(testModel.status?.toLowerCase() == 'error'){ CustomSnackbar.showCustomSnackbar(errorList: testModel.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);}
      await initData(fromChatStore: true);
      storeChatLoading=false;
      chatFieldController.text='';
      fileChooserModel=FileChooserModel(fileName: MyStrings.noFileChosen);
      update();
    }else{
      AuthorizationResponseModel testModel = AuthorizationResponseModel.fromJson(responseModel.responseJson);
      CustomSnackbar.showCustomSnackbar(errorList: [], msg: testModel.message?.error??[MyStrings.error], isError: false);
    }

  }

  void downloadFile(String? filename) async{
       bool permission = await _checkPermission();
       if(permission){
         await _prepareSaveDir();
         try {
           await Dio().download("${UrlContainer.baseUrl}$chatFilePath/${filename}",
               _localPath + "/" + "${filename}");
           CustomSnackbar.showCustomSnackbar(errorList: [], msg: ['File successfully downloaded in this path (${_localPath}/${filename})'], isError: false);
         } catch (e) {
           CustomSnackbar.showCustomSnackbar(errorList: ['Downloading fail for ${e.toString()}'], msg: [], isError: true);
         }
       }else{
            CustomSnackbar.showCustomSnackbar(errorList: ['Please give permission to download file'], msg: [], isError: true);
       }
  }
  
  late TargetPlatform? platform;
  String _localPath='';
  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  bool isFilePathIsPdf() {
    bool isPdf=false;
    try{
      isPdf = path.extension(fileChooserModel.choosenFile?.path??'').toLowerCase()=='.pdf'?true:false;
    }finally{

    }

    return isPdf;
  }

  void clearChosenFile() {
    fileChooserModel=FileChooserModel(fileName: MyStrings.noFileChosen.tr,choosenFile: null);
    update();
  }

 String getStatus() {
    String status=model.data?.tradeDetails?.status?.toString()??'';
    return status=='0'?MyStrings.escrowFunded:status=='2'?MyStrings.buyerPaid:status=='8'?MyStrings.tradeReported:status=='9'?MyStrings.canceled:status=='1'?MyStrings.completed:'';
 }

  String getStatusId() {
    String status=model.data?.tradeDetails?.status?.toString()??'';
    return status;
  }


  int getRemainingMin(){

    //when timer countdown enabled and time will be end then this variable will be true
    if(isRemainingMinutesEnd){
      return 0;
    }

    String? min = isBuyer?model.data?.buyerRemainingMin:model.data?.sellerRemainingMin;
    if(min!=null && min.isNotEmpty && min!='null'){
      int remainingMin = int.tryParse(min)??0;
      return remainingMin;
    }else{
      return 0;
    }
  }

  Color getStatusBgColor() {
    String status=model.data?.tradeDetails?.status?.toString()??'';
    return status=='0'?MyColor.primaryColor100:status=='2'?MyColor.primaryColor200:status=='8'?MyColor.closeRedColor:status=='9'?MyColor.redCancelTextColor:status=='1'?MyColor.greenSuccessColor:MyColor.primaryColor900;
  }

  void buyerButtonAction(int  s) async{

    // 1= i have paid
    // 2 = buyer cancel
    // 3 = buyer dispute

    buyerOrSellerBtnLoading=true;
    clickOn=s;
    update();
    ResponseModel response= await repo.changeStatus(model.data?.tradeDetails?.id.toString()??'-1', s==1?'paid':s==2?'cancel':'dispute');
    if(response.statusCode==200){
      AuthorizationResponseModel authorizationModel= AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(authorizationModel.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        await initData(fromChatStore: true);//bcz we not need to show loader
        buyerOrSellerBtnLoading=false;
        update();
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: authorizationModel.message?.error??[MyStrings.requestFail], msg: [], isError: true);
        buyerOrSellerBtnLoading=false;
        update();
      }
    }else{
      buyerOrSellerBtnLoading=false;
      update();
    }


  }

  bool reviewBtnLoading=false;
  TextEditingController reviewController=TextEditingController();
  bool isShowReview=false;
  bool alreadyReviewed = false;
  Future<bool> storeReview(String type) async{

    if(isPositive && isFirst){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.feedbackEmptyMsg], msg: [], isError: true);
      return false;
    }
    String feedback=reviewController.text.toString();
    if(feedback.isEmpty){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.reviewErrorMsg], msg: [], isError: true);
      return false;
    }

    reviewBtnLoading=true;
    update();

    ResponseModel response = await repo.storeReview(tradeNumber, type, feedback);
     if(response.statusCode==200){
      AuthorizationResponseModel authorizationModel= AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(authorizationModel.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: authorizationModel.message?.success??[MyStrings.success], isError: false);
        //isShowReview=false;
        reviewBtnLoading=false;
        update();
        return true;
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: authorizationModel.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
        reviewBtnLoading=false;
        update();
        return false;
      }
    }else{
      reviewBtnLoading=false;
      update();
      return false;
    }


  }

  bool buyerOrSellerBtnLoading=false;
  int clickOn=-1;
  void sellerButtonAction(int  s) async{
      buyerOrSellerBtnLoading=true;
      clickOn=s;
      update();
      ResponseModel response= await repo.changeStatus(model.data?.tradeDetails?.id.toString()??'-1', s==1?'cancel':s==2?'release':'dispute');
      if(response.statusCode==200){
        AuthorizationResponseModel authorizationModel= AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(authorizationModel.status?.toLowerCase()==MyStrings.success.toLowerCase()){
          await initData(fromChatStore: true);//bcz we not need to show loader
          buyerOrSellerBtnLoading=false;
          update();
        }else{
          CustomSnackbar.showCustomSnackbar(errorList: authorizationModel.message?.error??[MyStrings.requestFail], msg: [], isError: true);
          buyerOrSellerBtnLoading=false;
          update();
        }
      }else{
        buyerOrSellerBtnLoading=false;
        update();
      }



  }

  Future<void> onRefresh() async{
    await initData(fromChatStore: true);
    update();
    return;
  }

  void onLoading() async{
    await initData(fromChatStore: true);
    return;
  }


  String getTime(String time){
    if(time.isEmpty || time.length<5){
      return '----';
    }
    String date=DateConverter.getFormatedSubtractTime(time);
    return date;
  }

  bool isRemainingMinutesEnd=false;
  void changeRemMin({bool reemMinEnd=true}) {
    isRemainingMinutesEnd=reemMinEnd;
    update();
  }


  bool noInternet = false;
  void changeNoInternetStatus(bool status){
    noInternet=status;
    update();
  }

  bool isPositive=true;
  bool isUpdate=false;
  bool isFirst=true;

  void loadReview(){

  }

  changeReview(bool b){
    isPositive=b;
    isFirst=false;
    update();
  }





}