
import 'dart:convert';

import 'package:get/get.dart';
import '../../model/about/PoliciesResponseModel.dart';
import '../../model/global/response_model/response_model.dart';
import '../../../../view/components/show_custom_snackbar.dart';


import '../../repo/privacy_repo/privacy_repo.dart';


class PrivacyController extends GetxController{

  int selectedIndex=1;
  PrivacyRepo repo;
  bool isLoading=true;

  List<AllPolicy>list=[];

  late var selectedHtml='';

  PrivacyController({required this.repo});

  void loadData()async{
    isLoading=true;
    update();
    ResponseModel model=await repo.loadAboutData();
    if(model.statusCode==200){
      PrivacyResponseModel responseModel=PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      if(responseModel.data?.allPolicy !=null && !(responseModel.data!.allPolicy==[])){
            list.clear();
            list.addAll(responseModel.data!.allPolicy!);
            changeIndex(0);
            updateLoading(false);
      }
    }else{
            CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
            updateLoading(false);
    }
  }


  void changeIndex(int index){
    selectedIndex=index;
    selectedHtml = list[index].dataValues?.details??'';
    update();
  }

  updateLoading(bool status){
    isLoading=status;
    update();
  }
}