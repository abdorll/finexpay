

import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/data/repo/filter/filter_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/market_place/MarketPlaceResponseModel.dart';

class FilterResultController extends GetxController{

  FilterRepo repo;
  FilterResultController({required this.repo});

  int page=0;
  bool isLoading=true;
  String? nextPageUrl;
  String? imagePath = '';
  List<Ads> advertisementList = [];
  List<String>arguments=[];
  String serverType='';

  Future<void> loadData({var argument}) async {


    page=page+1;

    if(page==1){
      advertisementList.clear();
      arguments.clear();
     arguments.add(argument[0].toString());
     arguments.add(argument[1].toString());
     arguments.add(argument[2].toString());
     arguments.add(argument[3].toString());
     arguments.add(argument[4].toString()=='-1'?'':argument[4].toString());
     arguments.add(argument[5].toString()=='-1'?'':argument[5].toString());
     arguments.add(argument[6].toString()=='-1'?'':argument[6].toString());
      isLoading=true;
      update();
    }

    final ResponseModel response = await repo.getAdvertisement(arguments,page);

    if (response.statusCode == 200) {
      MarketPlaceResponseModel model =
     MarketPlaceResponseModel.fromJson(
          jsonDecode(response.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        serverType=model.data?.type??'';
        List<Ads>? tempList = model.data?.ads;
        nextPageUrl=model.data?.nextPageUrl;
        if (tempList != null && tempList.isNotEmpty) {
          imagePath = model.data?.gatewayImagePath.toString();
          advertisementList.addAll(tempList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }

    }
    else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);

    }

    if(page==1){
      isLoading=false;
    }
    update();
    return;
  }


  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty? true: false ;
  }



}