import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/data/model/auth/sign_up_model/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/helper/shared_pref_helper.dart';
import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../model/auth/registration_response_model.dart';
import '../../../model/auth/sign_up_model/sign_up_model.dart';
import '../../../model/country_model/CountryModel.dart';
import '../../../model/general_setting/GeneralSettingsResponseModel.dart';
import '../../../model/global/response_model/response_model.dart';
import '../../../repo/auth/general_setting_repo.dart';
import '../../../repo/auth/signup_repo.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({required this.registrationRepo, required this.generalSettingRepo});

  bool isLoading = false;
  bool agreeTC = false;

  //general setting
  GeneralSettingsResponseModel generalSettingMainModel =
  GeneralSettingsResponseModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree=true;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();


  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  String? firstName;
  String? lastName;

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  bool submitLoading=false;
  signUpUser() async {
    if (countryName == null) {
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.selectACountry], msg: [], isError: true);
      update();
      return;
    } if(mobileController.text.isEmpty) {
      CustomSnackbar.showCustomSnackbar(
          errorList: [MyStrings.kPhoneNumberNullError], msg: [], isError: true);
      return;
    }
      submitLoading=true;
      update();
    SignUpModel model = getUserData();
    final responseModel = await registrationRepo.registerUser(model);
    if (responseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      CustomSnackbar.showCustomSnackbar(errorList: [''],msg:responseModel.message?.success ??[MyStrings.success],isError: false);
      checkAndGotoNextStep(responseModel);
    } else {
      CustomSnackbar.showCustomSnackbar(errorList:responseModel.message?.error ?? [''],msg: [],isError: true);
    }

    submitLoading=false;
    update();
  }



  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  bool isValidPassword(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {
    SignUpModel model = SignUpModel(
        mobile: mobileController.text.toString(),
        email: emailController.text.toString(),
        agree: agreeTC ? true : false,
        username: userNameController.text.toString(),
        password: passwordController.text.toString(),
        country: countryName.toString(),
        mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
        countryCode: countryCode??'',
       );

    return model;
  }


  void checkAndGotoNextStep(RegistrationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == "1" ? false : true;
    bool isTwoFactorEnable =  false;

    SharedPreferences preferences=registrationRepo.apiClient.sharedPreferences;

    await preferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString()??'-1');
    await preferences.setString(SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken ?? '');
    await preferences.setString(SharedPreferenceHelper.accessTokenType,
        responseModel.data?.tokenType ?? '');
    await preferences.setString(SharedPreferenceHelper.userEmailKey,
        responseModel.data?.user?.email ?? '');
    await preferences.setString(SharedPreferenceHelper.userNameKey,
        responseModel.data?.user?.username ?? '');
    await preferences.setString(SharedPreferenceHelper.userPhoneNumberKey,
        responseModel.data?.user?.mobile ?? '');


    bool isProfileCompleteEnable = true;

    if(needEmailVerification == false && needSmsVerification == false){
      Get.offAndToNamed(RouteHelper.profileComplete);
    }
    else if(needEmailVerification == true && needSmsVerification == true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true,isProfileCompleteEnable,isTwoFactorEnable]);
    }
    else if(needEmailVerification){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [false,isProfileCompleteEnable,isTwoFactorEnable]);
    }
    else if(needSmsVerification){
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,arguments: [isProfileCompleteEnable,isTwoFactorEnable]);
    }



  }

  void closeAllController() {
    isLoading=false;
    emailController.text='';
    passwordController.text='';
    cPasswordController.text='';
    fNameController.text='';
    lNameController.text='';
    mobileController.text='';
    countryController.text='';
    userNameController.text='';
  }
  clearAllData() {
    closeAllController();
  }

  bool isCountryLoading=true;

  void initData() async {

    isCountryLoading = true;
    await getCountryData();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();
    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()=='success') {
        generalSettingMainModel =model;
        registrationRepo.apiClient.storeGeneralSetting(model);
      } else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackbar.showCustomSnackbar(errorList:model.message?.error??message, msg:[], isError: true);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackbar.showCustomSnackbar(errorList:[response.message], msg:[], isError: true);
      return;
    }



    needAgree =
    generalSettingMainModel.data?.generalSetting?.agree.toString() == '0'
        ? false
        : true;
    checkPasswordStrength = generalSettingMainModel
        .data?.generalSetting?.securePassword
        .toString() ==
        '0'
        ? false
        : true;
    isCountryLoading=false;
    update();
  }

  bool countryLoading = true;
  List<Countries> countryList = [];

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await registrationRepo.getCountryList();


    if (mainResponse.statusCode == 200) {

      var json=jsonDecode(mainResponse.responseJson);
      var countryMap=json['data']['countries'] as Map<String,dynamic>;


      countryList.clear();

      countryMap.forEach((key, value) {
       var country= Countries(country:value['country'],dialCode:value['dial_code'],countryCode: key);
        countryList.add(country);
       });


      countryLoading = false;
      update();

      return;

    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [mainResponse.message], msg: [], isError: true);

      countryLoading = false;
      update();
      return;
    }
  }

  String? validatPassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if(checkPasswordStrength){
        if (!regex.hasMatch(value)) {
          return MyStrings.kInvalidPassError.tr;
        } else {
          return null;
        }
      }else{
        return null;
      }

    }
  }

  bool noInternet=false;
  void changeNotification(bool hasInternet){
    noInternet=false;
    initData();
    update();
  }

  List<ErrorModel> passwordValidationRulse = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  void updateValidationList(String value){
    passwordValidationRulse[0].hasError = value.contains(RegExp(r'[A-Z]'))?false:true;
    passwordValidationRulse[1].hasError = value.contains(RegExp(r'[a-z]'))?false:true;
    passwordValidationRulse[2].hasError = value.contains(RegExp(r'[0-9]'))?false:true;
    passwordValidationRulse[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))?false:true;
    passwordValidationRulse[4].hasError = value.length>=6?false:true;

    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  bool hasMobileFocus = false;
  void changeMobileFocus(bool hasFocus) {
    hasMobileFocus = hasFocus;
    update();
  }


}
