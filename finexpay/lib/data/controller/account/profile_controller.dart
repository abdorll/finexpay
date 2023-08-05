
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../../constants/my_strings.dart';
import '../../../core/helper/shared_pref_helper.dart';
import '../../model/account/ProfileResponseModel.dart';
import '../../model/account/user_post_model/UserPostModel.dart';
import '../../repo/account/profile_repo.dart';



class ProfileController extends GetxController implements GetxService {

  ProfileRepo profileRepo;

  ProfileResponseModel model=ProfileResponseModel();

  String imageStaticUrl='';

  ProfileController({required this.profileRepo});

  List<String> errors = [];
  String imageUrl='';
  String? currentPass, password, confirmPass;
  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();


  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;




  loadProfileInfo() async {
    isLoading = true;
    update();
    model= await profileRepo.loadProfileInfo();
    if(model.data!=null && model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      loadData(model);
    }else{
      isLoading=false;
      update();
    }

  }

  void clearAllData() {

  }

  updateProfile()async{

    String firstName=firstNameController.text;
    String lastName=lastNameController.text.toString();
    String address=addressController.text.toString();
    String city=cityController.text.toString();
    String zip=zipCodeController.text.toString();
    String state=stateController.text.toString();
    User? user=model.data?.user;

    if(firstName.isNotEmpty && lastName.isNotEmpty){
      isLoading=true;
      update();

      UserPostModel model=UserPostModel(
          firstname: firstName, lastName: lastName, mobile: user?.mobile??'', email: user?.email??'',
          username: user?.username??'', countryCode: user?.countryCode??'', country: user?.address?.country??'', mobileCode: '880',
          image:imageFile, address: address, state: state,
          zip: zip, city: city);

      bool b= await profileRepo.updateProfile(model,'profile');

      if(b){
        await loadProfileInfo();
      }

      isLoading=false;
      update();
    }else{
      if(firstName.isEmpty){
        CustomSnackbar.showCustomSnackbar(errorList: [ MyStrings.kFirstNameNullError], msg: [], isError: true);
      } if(lastName.isEmpty){
        CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.kLastNameNullError], msg: [], isError: true);
      }
    }

  }

  void loadData(ProfileResponseModel? model) {
    firstNameController.text=model?.data?.user?.firstname??'';
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');
    lastNameController.text = model?.data?.user?.lastname??'';
    emailController.text = model?.data?.user?.email??'';
    mobileNoController.text = model?.data?.user?.mobile??'';
    addressController.text =model?.data?.user?.address?.address??'';
    stateController.text = model?.data?.user?.address?.state??'';
    zipCodeController.text = model?.data?.user?.address?.zip??'';
    cityController.text = model?.data?.user?.address?.city??'';
    imageUrl=model?.data?.user?.image==null?'':'${model?.data?.user?.image}';
    isLoading=false;

    update();
  }
}
