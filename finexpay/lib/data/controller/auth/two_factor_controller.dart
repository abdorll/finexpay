import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/repo/auth/two_factor_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

class TwoFactorController extends GetxController {

  TwoFactorRepo repo;
  TwoFactorController({required this.repo});
  bool isProfileCompleteEnable = false;

  bool submitLoading=false;
  String currentText='';
  verifyYourSms(String currentText) async {

    if (currentText.isEmpty) {
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.otpEmptyMsg], msg: [], isError: true );
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success.toLowerCase()) {

        CustomSnackbar.showCustomSnackbar(errorList:[],msg:model.message?.success ?? [MyStrings.requestSuccess],isError:false);
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
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.requestFail],msg: [],isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message],msg: [],isError: true);
    }
    submitLoading = false;
    update();

  }


}