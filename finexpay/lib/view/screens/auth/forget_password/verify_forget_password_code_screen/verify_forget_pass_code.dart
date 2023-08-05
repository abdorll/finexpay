
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../../../core/utils/my_color.dart';
import '../../../../../constants/my_strings.dart';
import '../../../../../core/route/route.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../../data/services/api_service.dart';

import '../../../../components/CustomBackSupportAppbar.dart';
import '../../../../components/rounded_button.dart';
import '../../../../components/text/light_text.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {



  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find(),sharedPreferences: Get.find()));
    final controller=Get.put(ForgetPasswordController(loginRepo: Get.find()));
    controller.email=Get.arguments;
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                CustomBackSupportAppBar(press: (){
                  Get.offAndToNamed(RouteHelper.loginScreen);
                },title:  MyStrings.passVerification,),
                GetBuilder<ForgetPasswordController>(
                  builder: (controller) => controller.isLoading
                      ?
                  const Center(child: CircularProgressIndicator(color: MyColor.primaryColor,)): Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 35,),
                        Center(
                          child: Image.asset(MyImages.emailLogo,height: 110,width: 110,fit: BoxFit.cover,),
                        ),
                        const SizedBox(height: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width*.1, vertical: 8),
                                child: LightText(text: MyStrings.weHaveSentEmailVerificationCode.tr,isAlignCenter: true,
                                )),

                          ],
                        ),
                        const SizedBox(height: 17),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: mulishSemiBold.copyWith(
                                  color: MyColor.primaryColor400),
                              length: 6,
                              textStyle: mulishSemiBold.copyWith(color: MyColor.colorBlack),
                              obscureText: false,
                              obscuringCharacter: '*',
                              blinkWhenObscuring: false,
                              animationType: AnimationType.none,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderWidth: 1,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 40,
                                  fieldWidth: 40,
                                  inactiveColor:  MyColor
                                      .primaryColor400,
                                  inactiveFillColor: MyColor.transparentColor,
                                  activeFillColor: MyColor.transparentColor,
                                  activeColor: MyColor.primaryColor,
                                  selectedFillColor:
                                  MyColor.colorWhite,
                                  selectedColor: MyColor
                                      .primaryColor),
                              cursorColor: Colors.black,
                              animationDuration:
                              const Duration(milliseconds: 100),
                              enableActiveFill: true,

                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  controller.currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                return true;
                              },
                            )),

                        const SizedBox(height: 30,),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: controller.verifyLoading
                              ?const RoundedLoadingBtn()
                              : RoundedButton(
                              text: MyStrings.verify.tr,
                              press: () {
                                if (controller.currentText.length != 6) {
                                  controller.hasError=true;
                                } else {
                                  controller.verifyForgetPasswordCode(controller.currentText);
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child:Text(
                               MyStrings.didNotReceiveCode.tr,
                                style: mulishRegular.copyWith( fontSize: Dimensions.fontLarge),
                              ) ,
                            ),
                            Center(
                              child:  controller.isResendLoading? Container(margin: const EdgeInsets.all(5),height:20,width:20,child: const CircularProgressIndicator(color: MyColor.primaryColor,)):GestureDetector(
                                  onTap: () {
                                    controller.resendForgetPassCode();
                                  },
                                  child: Text(MyStrings.resend.tr,
                                      style: mulishBold.copyWith(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          color:
                                          MyColor.primaryColor))),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

