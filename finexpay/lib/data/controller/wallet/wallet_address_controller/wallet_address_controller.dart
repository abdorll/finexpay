

import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/wallet/single_wallet_address_response_model/SingleWalletResponseModel.dart';
import 'package:local_coin/data/repo/wallet_repo/wallet_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

class WalletAddressController extends GetxController{
  
  WalletRepo repo;
  WalletAddressController({required this.repo});

  bool isLoading=true;
  List<Data>walletAddressList=[];
  String? nextUrl;
  String imagePath='';
  String totalAddress='0';

  bool generateAddressLoading=false;

  bool noInternet = false;
  void changeNoInternetStatus(bool status){
    noInternet=status;
    update();
  }

  void generateNewAddress()async{
    generateAddressLoading=true;
    update();
    ResponseModel response= await repo.generateAddress(walletId);
   if(response.statusCode==200){
     AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
     if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
       await initData(walletId);
       CustomSnackbar.showCustomSnackbar(errorList: [], msg:model.message?.error??[MyStrings.success], isError: true);
       Get.back();
     }else{
       Get.back();
       showError(model.message?.error??[MyStrings.requestFail]);
     }
   }else{
     Get.back();
     showError([response.message]);
   }
   generateAddressLoading=false;
   update();

  }
  int walletId=-1;

  int page=0;
  Future<void> initData(int id)async{
    walletId=id;
    isLoading=true;
    page=1;
    update();
   final ResponseModel response=await repo.getAddressList(walletId,page);
   if(response.statusCode==200){
     SingleWalletAddressResponseModel model=SingleWalletAddressResponseModel.fromJson(jsonDecode(response.responseJson));
     if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
       totalAddress=model.mainData?.totalAddressCount??'0';
       nextUrl=model.mainData?.cryptoWalletAddresses?.nextPageUrl;
       imagePath='${model.mainData?.cryptoImagePath}/${model.mainData?.crypto?.image}';
       List<Data>?tempList=model.mainData?.cryptoWalletAddresses?.data;
       if(tempList!=null && tempList.isNotEmpty){
         walletAddressList.clear();
         walletAddressList.addAll(tempList);
       }
     }else{
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
     }

   }else{
     if(response.statusCode==503){
       changeNoInternetStatus(true);
     }
     showError([response.message]);
   }
    isLoading=false;
    update();
  }

  Future<void> loadData()async{
    page=page+1;
    final ResponseModel response=await repo.getAddressList(walletId,page);
    if(response.statusCode==200){
      SingleWalletAddressResponseModel model=SingleWalletAddressResponseModel.fromJson(jsonDecode(response.responseJson));
      nextUrl=model.mainData?.cryptoWalletAddresses?.nextPageUrl;
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        List<Data>?tempList=model.mainData?.cryptoWalletAddresses?.data;
        if(tempList!=null && tempList.isNotEmpty){
          walletAddressList.addAll(tempList);
        }
      }else{
        showError(model.message?.error??[MyStrings.somethingWentWrong]);
      }
    }else{
      showError([response.message]);
    }
    update();
  }

  bool hasNext(){
    return nextUrl!=null && nextUrl!.isNotEmpty && nextUrl!.toLowerCase()!='null'?true:false;
  }


  void showError(List<String> message){
        CustomSnackbar.showCustomSnackbar(errorList: message, msg: [], isError: true);
  }


}