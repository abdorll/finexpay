import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/components/header_text.dart';
import 'package:local_coin/view/components/label_text.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/text/light_text.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/login_controller.dart';
import '../../../../data/repo/auth/login_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/rounded_button.dart';
import '.././../../../core/utils/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool b = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppLock.of(context)?.setEnabled(true);
      b = true;
      Get.find<LoginController>().isLoading = false;
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    b = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bgColor,
            body:  SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height *.03,
                        ),
                        const HeaderText(text: MyStrings.wellComeBack),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.32),
                          child: const LightText(text: MyStrings.happyToSeeYouAgain),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height *.035,
                        ),
                        CustomTextFormField(
                          isUnderline: true,
                          hintText: MyStrings.enterUserNameOrEmail,
                          isShowBorder: true,
                          isPassword: false,
                          isShowPrefixIcon:false,
                          controller: controller.emailController,
                          isShowSuffixIcon: false,
                          fillColor: MyColor.bgColor1,
                          label:MyStrings.emailOrUserName,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          focusNode: controller.emailFocusNode,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return MyStrings.enterEmailOrUsername.tr;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            return;
                          },
                          nextFocus: controller.passwordFocusNode,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          isShowBorder: true,
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocusNode,
                          hintText: MyStrings.enterYourPassword_,
                          fillColor: MyColor.bgColor1,
                          isShowSuffixIcon: true,
                          label:MyStrings.password,
                          isUnderline: true,
                          isShowPrefixIcon: false,
                          isPassword: true,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return MyStrings.kPassNullError.tr;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 23,
                                      height: 25,
                                      child: Checkbox(
                                          activeColor: MyColor.primaryColor,
                                          value: controller.remember,
                                          side: MaterialStateBorderSide.resolveWith(
                                                (states) => BorderSide(
                                                width: 1.0,
                                                color: controller.remember
                                                    ? MyColor.transparentColor
                                                    : MyColor.primaryColor),
                                          ),
                                          onChanged: (value) {
                                            controller.changeRememberMe();
                                          }),
                                    ),
                                    const SizedBox(width: 12,),
                                    Expanded(child:  Text(
                                      MyStrings.rememberMe.tr,
                                      style: mulishSemiBold.copyWith(
                                          fontSize: Dimensions.fontDefault),
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                            Flexible(

                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.forgetPasswordScreen);
                                  },
                                  child: Text(
                                    MyStrings.forgetPassword.tr,
                                    style: mulishSemiBold.copyWith(
                                        color: MyColor.primaryColor,
                                        fontSize: Dimensions.fontDefault),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        controller.isLoading
                            ?const RoundedLoadingBtn(): RoundedButton(
                          press: () {
                            if(formKey.currentState!.validate()){
                              controller.loginUser();
                            }
                          },
                          text: MyStrings.login,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.15,),
                        Center(
                          child: Text(
                            MyStrings.notAccount.tr,
                            style: mulishRegular.copyWith(
                                fontSize: Dimensions.fontLarge),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.emailController.text='';
                              controller.passwordController.text='';
                              controller.remember=false;
                              Get.offAndToNamed(RouteHelper.registrationScreen);
                            },
                            child: Text(
                              MyStrings.createNew.tr,
                              style: mulishBold.copyWith(
                                  fontSize: 18, color: MyColor.primaryColor),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height:30,
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),

              ),
            ),
        ),
      ),
    );
  }
}
