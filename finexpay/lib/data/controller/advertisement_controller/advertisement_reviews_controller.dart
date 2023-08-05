
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/data/model/advertisement/AdvertisementReviewResponseModel.dart';
import 'package:local_coin/data/repo/advertisement_repo/advertisement_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class AdvertisementReviewController extends GetxController{

  AdvertisementRepo repo;
  AdvertisementReviewController({required this.repo});
  bool isLoading=true;
  List<Reviews>reviewList=[];
  String? nextUrl;
  int page=0;
  int adId=0;

  Future<void> initData()async{
    page=page+1;
    if(page==1){
      reviewList.clear();
      isLoading=true;
      update();
    }
    final ResponseModel response=await repo.getAdvertisementReviewList(page,adId);
    if(response.statusCode==200){
     AdvertisementReviewResponseModel model = AdvertisementReviewResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){

        List<Reviews>?tempList=model.data?.reviews;
        nextUrl=model.data?.nextPageUrl;
        if(tempList!=null && tempList.isNotEmpty){
          reviewList.addAll(tempList);
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



}