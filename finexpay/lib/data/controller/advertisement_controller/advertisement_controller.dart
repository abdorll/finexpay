
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/data/model/advertisement/MainAdvertisementResponseModel.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/repo/advertisement_repo/advertisement_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class AdvertisementController extends GetxController{

  AdvertisementRepo repo;
  AdvertisementController({required this.repo});
  bool isLoading=true;
  List<Ads>advertisementList=[];
  String? nextUrl;
  String imagePath='';
  String cryptoPath='';
  int totalAdvertisement=0;
  int page=0;

  Future<void> initData()async{
    page=page+1;
    if(page==1){
      advertisementList.clear();
      isLoading=true;
      update();
    }
    final ResponseModel response=await repo.getAdvertisementList(page);
    if(response.statusCode==200){
     MainAdvertisementResponseModel model=MainAdvertisementResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        totalAdvertisement=model.mainData?.adCount??0;
        imagePath='${model.mainData?.gatewayImagePath}';
        cryptoPath='${model.mainData?.cryptoImagePath}';
        List<Ads>?tempList=model.mainData?.ads;
        nextUrl=model.mainData?.nextPageUrl;
        if(tempList!=null && tempList.isNotEmpty){
          advertisementList.addAll(tempList);
        }
      }else{
           showError(model.message?.error??[MyStrings.somethingWentWrong]);
      }

    }
    else{
      showError([response.message]);
    }
    isLoading=false;
    update();
  }

  bool hasNext(){
    return nextUrl!=null && nextUrl!.isNotEmpty?true:false;
  }

  void showError(List<String> message){
    CustomSnackbar.showCustomSnackbar(errorList: message, msg: [], isError: true);
  }

  bool activeStatus=false;
  bool isStatusUpdating=false;
  void changeActiveStatus(bool value,int id)async{
    isStatusUpdating=true;
    update();
    ResponseModel response = await repo.updateAdvertisementStatus(id);
    if(response.statusCode==200){
      AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        Get.back();
        CustomSnackbar.showCustomSnackbar(errorList: [], msg:model.message?.success??[MyStrings.statusUpdateSuccess], isError: false);
        activeStatus=value;
      } else{
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.error??[MyStrings.statusUpdateFailed], isError: true);
      }
    }
    else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [''], isError: true);
    }
    isStatusUpdating=false;
    page=0;
    await initData();
    update();
    Get.back();
  }

}