import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';

import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../repo/auth/sms_email_verification_repo.dart';

class SmsVerificationController extends GetxController implements GetxService {
  SmsEmailVerificationRepo repo;

  SmsVerificationController({required this.repo});

  bool hasError = false;
  bool isLoading = true;
  String currentText='';
  bool isProfileCompleteEnable=false;
  bool isTwoFactorEnable = false;



  Future<void> loadBefore() async {
    isLoading=true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading=false;
    update();
    return;
  }


  bool submitLoading=false;
  verifyYourSms(String currentText) async {
    if (currentText.isEmpty) {
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.otpEmptyMsg],msg: [],isError:true);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel =
    await repo.verify(currentText, isEmail: false, isTFA: false);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success.toLowerCase()) {

        CustomSnackbar.showCustomSnackbar(errorList: [],msg:model.message?.success ?? [MyStrings.requestSuccess],isError: false);
        if(isTwoFactorEnable){
          Get.offAndToNamed(RouteHelper.twoFactorScreen,arguments:isProfileCompleteEnable );
        } else{
          String pin = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.screenLockPin)??'';
          if(pin.isEmpty || pin=='null'){
            Get.offAndToNamed(RouteHelper.createPinScreen);
          } else{
            Get.offAndToNamed(RouteHelper.homeScreen);
          }
        }

      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.requestFail],msg: [],isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message],msg: [],isError:true);
    }

    submitLoading = false;
    update();
  }

  bool resendLoading=false;
  Future<void> sendCodeAgain() async {
    resendLoading=true;
    update();
    await repo.resendVerifyCode(isEmail: false);
    resendLoading=false;
    update();
  }
}
