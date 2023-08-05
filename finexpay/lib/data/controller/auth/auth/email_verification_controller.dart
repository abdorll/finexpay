import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../repo/auth/sms_email_verification_repo.dart';

class EmailVerificationController extends GetxController
    implements GetxService {
  bool dataLoading = true;
  bool isLoading = false;
  bool resendLoading = false;
  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});


  String currentText = "";
  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;
  bool needTwoFactor = false;
  bool submitLoading=false;

  loadData() async {
    dataLoading = true;
    await repo.sendAuthorizationRequest();
    dataLoading = false;
    update();
  }

  verifyEmail(String text) async {

    if (text.isEmpty) {
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.otpFieldEmptyMsg], msg: [], isError: true);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        if(needSmsVerification){
          Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable,needTwoFactor]);
        } else if(needTwoFactor){
          Get.offAndToNamed( RouteHelper.twoFactorScreen,arguments: isProfileCompleteEnable);
        }
        else{
          if(isProfileCompleteEnable){
            Get.offAndToNamed(RouteHelper.profileComplete);
          } else{
            String pin = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.screenLockPin)??'';
            if(pin.isEmpty || pin=='null'){
              Get.offAndToNamed(RouteHelper.createPinScreen);
            } else{
              Get.offAndToNamed(RouteHelper.homeScreen);
            }
          }
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??['${MyStrings.email} ${MyStrings.verificationFailed}'],msg: [],isError: true );
      }
    }
    else {
      CustomSnackbar.showCustomSnackbar(errorList:[responseModel.message],msg: [],isError: true);
    }

    submitLoading=false;
    update();
  }

  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }

  void clearData() {
    isLoading = false;
    dataLoading = true;
  }

}
