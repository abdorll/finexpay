import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../model/auth/verification/email_verification_model.dart';
import '../../../repo/auth/login_repo.dart';

class ForgetPasswordController extends GetxController {
  LoginRepo loginRepo;


  List<String> errors = [];
  String email='';
  String password='';
  String confirmPassword='';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;
  String currentText = "";

  ForgetPasswordController({required this.loginRepo});

  addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  void submitForgetPassCode() async {
    if (errors.isNotEmpty) {
      return;
    }
    if(email.isEmpty){
      addError(error: MyStrings.kEmailNullError);
      return;
    }
    if(email.isNotEmpty){
      removeError(error: MyStrings.kEmailNullError);
    }

      isLoading = true;
      update();
      String value = email;
      String type = value.contains('@') ? 'email' : 'username';
      String responseEmail = await loginRepo.forgetPassword(type, value);
      if(responseEmail.isNotEmpty){
        Get.toNamed(RouteHelper.verifyPassCodeScreen,arguments: responseEmail);
      }else{

      }
      isLoading = false;
      update();

  }

  bool isResendLoading=false;
  void resendForgetPassCode() async {
    isResendLoading=true;
    update();
    String value = email;
    String type = 'email';
     await loginRepo.forgetPassword(type, value);
    isResendLoading=false;
    update();
  }

  bool verifyLoading=false;

  void verifyForgetPasswordCode(String value) async{
       if(value.isNotEmpty){
         verifyLoading=true;
         update();
        EmailVerificationModel model= await loginRepo.verifyForgetPassCode(value);

        if(model.status=='success'){
          verifyLoading=false;
          Get.offAndToNamed(RouteHelper.resetPasswordScreen,arguments: [email,value]);
          clearAllData();
        }else{
          verifyLoading=false;
          update();
          List<String>errorList=[MyStrings.verificationFailed];
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??errorList, msg: [], isError: true);
        }
       }
  }


  clearAllData(){
    isLoading=false;
    currentText='';
  }

}
