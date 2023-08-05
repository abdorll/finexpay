import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/data/controller/auth/auth/reset_password_controller.dart';
import 'package:local_coin/view/components/custom_text_form_field.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/validation_widget/validation_widget.dart';
import 'package:local_coin/view/screens/auth/forget_password/forget_password_screen/widget/heading_text_widget.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/route/route.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/CustomBackSupportAppbar.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/rounded_button.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find(),sharedPreferences: Get.find()));
    final controller =Get.put(ResetPasswordController(loginRepo: Get.find()));
    controller.email=Get.arguments[0];
    controller.token = Get.arguments[1];
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find(), sharedPreferences: Get.find()));
    Get.put(ResetPasswordController(loginRepo: Get.find()));
    super.initState();
  }
  

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child:  CustomBackSupportAppBar(
          title:MyStrings.resetPassword,press: (){
            Get.offAndToNamed(RouteHelper.loginScreen);
          }),
        ),
        body: GetBuilder<ResetPasswordController>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingTextWidget(header:MyStrings.resetYourPass ,body:MyStrings.resetLabelText,),
                    const SizedBox(
                      height: 40,
                    ),
                    Visibility(
                        visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                        child: ValidationWidget(list: controller.passwordValidationRulse, heightBottom: 15)),
                    Column(
                        children: [

                          Focus(
                            onFocusChange: (hasFocus){
                              controller.changePasswordFocus(hasFocus);
                            },
                            child: CustomTextFormField(
                                isUnderline: true,
                                focusNode: controller.passwordFocusNode,
                                nextFocus: controller.confirmPasswordFocusNode,
                                hintText: MyStrings.password,
                                label: MyStrings.password,
                                isShowSuffixIcon: true,
                                isPassword: true,
                                controller: controller.passController,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  return controller.validatPassword(value ?? '');
                                },
                                onChanged: (value) {
                                  if(controller.checkPasswordStrength){
                                    controller.updateValidationList(value);
                                  }
                                  return;
                                }),
                          ),
                          const SizedBox(height: 15),
                          CustomTextFormField(
                              label: MyStrings.confirmPassword,
                              isUnderline: true,
                              controller: controller.confirmPassController,
                              inputAction: TextInputAction.done,
                              isPassword: true,
                              hintText: MyStrings.confirmPassword,
                              isShowSuffixIcon: true,
                              onChanged: (value){
                                return;
                              },
                              validator: (value) {
                                if (controller.passController.text.toLowerCase() != controller.confirmPassController.text.toLowerCase()) {
                                  return MyStrings.kMatchPassError.tr;
                                } else {
                                  return null;
                                }
                              }
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          controller.submitLoading
                              ? const RoundedLoadingBtn()
                              : RoundedButton(
                            width: 1,
                            text: MyStrings.submit,
                            press: () {
                              if (formKey.currentState!.validate()) {
                                controller.resetPassword();
                              }
                            },
                          ),
                        ],
                      ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

