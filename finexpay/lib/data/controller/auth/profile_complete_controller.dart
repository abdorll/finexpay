import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/data/model/account/ProfileResponseModel.dart';
import 'package:local_coin/data/model/account/user_post_model/UserPostModel.dart';
import 'package:local_coin/data/repo/account/profile_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';




class ProfileCompleteController extends GetxController {

  ProfileRepo profileRepo;

  ProfileResponseModel model = ProfileResponseModel();

  ProfileCompleteController({required this.profileRepo});

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


  bool submitLoading=false;
  updateProfile()async{

    String firstName = firstNameController.text;
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();


    if(firstName.isEmpty){
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.kFirstNameNullError],isError: true,msg: []);
      return;
    }else if(lastName.isEmpty){
      CustomSnackbar.showCustomSnackbar(msg:[],isError:true,errorList: [MyStrings.kLastNameNullError]);
      return;
    }


    submitLoading=true;
    update();

    UserPostModel model = UserPostModel(
        image: null,
        firstname: firstName, lastName: lastName, mobile: '', email: '',
        username: '', countryCode: '', country: '', mobileCode: '8',
        address: address, state: state,
        zip: zip, city: city);

    bool b = await profileRepo.updateProfile(model,'profile_complete');

    if(b){
      String pin = profileRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.screenLockPin)??'';
      if(pin.isEmpty || pin=='null'){
        Get.offAndToNamed(RouteHelper.createPinScreen);
      } else{
        Get.offAllNamed(RouteHelper.homeScreen);
      }
      return;
    }

    submitLoading=false;
    update();

  }

}
