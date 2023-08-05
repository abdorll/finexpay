

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';

import '../../../view/components/show_custom_snackbar.dart';
import '../../model/kyc/KycResponseModel.dart';
import '../../repo/kyc/kyc_repo.dart';


class KycController extends GetxController {

  KycRepo repo;
  KycController({required this.repo});
  File? imageFile;


  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;


  KycResponseModel model = KycResponseModel();
  bool isNoDataFound=false;
  bool isAlreadyVerified=false;
  bool isAlreadyPending=false;

  beforeInitLoadKycData() async {
    setStatusTrue();
    try{
      model=await repo.getKycData() ;
      if(model.data!=null && model.status?.toLowerCase()== MyStrings.success.toLowerCase()){
        List<FormModel>? tList = model.data?.form?.list;
        if (tList != null && tList.isNotEmpty) {
          formList.clear();
          for (var element in tList) {
            if (element.type == 'select') {
              bool? isEmpty = element.options?.isEmpty;
              bool empty = isEmpty ?? true;
              if (element.options != null && empty != true) {
                element.options?.insert(0, selectOne);
                element.selectedValue = element.options?.first;
                formList.add(element);
              }
            } else {
              formList.add(element);
            }
          }
        }

        isNoDataFound=false;
        setStatusFalse();
      }else{
        if(model.remark?.toLowerCase()=='already_verified'){
           isAlreadyVerified=true;
           setStatusFalse();
        }else if(model.remark?.toLowerCase()=="under_review"){
          isAlreadyPending=true;
          setStatusFalse();
        }
        else{
          isNoDataFound=true;
          setStatusFalse();
        }
      }
    }finally{

    }

    setStatusFalse();
  }

  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
  }


  bool submitLoading=false;
  submitKycData() async {

    List<String> list = hasError();


    if (list.isNotEmpty) {
      CustomSnackbar.showCustomSnackbar(
          errorList: list, msg: [], isError: true);
      return;
    }
    submitLoading=true;
    update();

    AuthorizationResponseModel response =await repo.submitKycData(formList);

    if(response.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      isAlreadyPending = true;
      CustomSnackbar.showCustomSnackbar(errorList: [], msg: response.message?.success??['Submitted'], isError: false);
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: response.message?.error??[MyStrings.requestFail], msg: [], isError: true);
    }

    submitLoading=false;
    update();

  }

  List<String> hasError() {
    List<String> errorList = [];
    errorList.clear();
    for (var element in formList) {
      if (element.isRequired == 'required') {
        if(element.type=='checkbox'){
          if (element.cbSelected == null ) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }else if(element.type=='file'){
          if (element.imageFile==null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }else{
          if (element.selectedValue == '' || element.selectedValue == selectOne) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }

      }
    }
    return errorList;
  }


  void pickFile(int index) async{

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

    if (result == null) return;

    formList[index].imageFile = File(result.files.single.path!);
    String fileName = result.files.single.name;
    formList[index].selectedValue = fileName;
    update();
    return;
  }


  void changeSelectedValue(value, int index) {
    formList[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList[listIndex].selectedValue =
    formList[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {

    List<String>list=value.split('_');
    int index=int.parse(list[0]);
    bool status=list[1]=='true'?true:false;

    List<String>?selectedValue=formList[listIndex].cbSelected;

    if(selectedValue!=null){
          String? value=formList[listIndex].options?[index];
          if(status){
            if(!selectedValue.contains(value)){
              selectedValue.add(value!);
              formList[listIndex].selectedValue=selectedValue;
              update();
            }
          }else{
            if(selectedValue.contains(value)){
              selectedValue.removeWhere((element) => element==value);
              formList[listIndex].selectedValue=selectedValue;
              update();
            }
          }
    }else{
      selectedValue=[];
      String? value=formList[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          formList[listIndex].cbSelected=selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          formList[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }

  }


}