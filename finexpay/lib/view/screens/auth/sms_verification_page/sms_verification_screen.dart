import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/auth/sms_verification_controler.dart';
import '../../../../data/repo/auth/sms_email_verification_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/rounded_button.dart';
import '../../../components/text/light_text.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SmsVerificationController>().loadBefore();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SmsPinVerificationBody();
  }
}

class SmsPinVerificationBody extends StatefulWidget {
  const SmsPinVerificationBody({Key? key}) : super(key: key);

  @override
  State<SmsPinVerificationBody> createState() => _SmsPinVerificationBodyState();
}

class _SmsPinVerificationBodyState extends State<SmsPinVerificationBody> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.isProfileCompleteEnable=Get.arguments[0];
      controller.isTwoFactorEnable = Get.arguments[1];
      controller.loadBefore();
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const CustomAppBar(
          fromAuth: true,
          title: MyStrings.smsVerification,
          isShowBackBtn: true,
          isShowActionBtn: false,
          bgColor: Colors.transparent,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<SmsVerificationController>(
            builder: (controller) => controller.isLoading
                ? const Center(child: CircularProgressIndicator(color: MyColor.primaryColor,))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              Center(
                                child: Image.asset(
                                  MyImages.emailLogo,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width*.2, vertical: 8),
                                      child: const LightText(
                                        text:MyStrings.smsVerificationMsg,
                                        isAlignCenter: true,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 17),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 30),
                                  child: PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle:
                                        mulishSemiBold.copyWith(
                                            color: MyColor.primaryColor400),
                                    length: 6,
                                    textStyle: mulishSemiBold.copyWith(
                                        color: MyColor.colorBlack),
                                    obscureText: false,
                                    obscuringCharacter: '*',
                                    blinkWhenObscuring: false,
                                    animationType: AnimationType.fade,
                                    pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderWidth: 1,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 40,
                                        fieldWidth: 40,
                                        inactiveColor: MyColor.primaryColor400,
                                        inactiveFillColor: MyColor.transparentColor,
                                        activeFillColor: MyColor.transparentColor,
                                        activeColor: MyColor.primaryColor,
                                        selectedFillColor: MyColor.colorWhite,
                                        selectedColor: MyColor.primaryColor),
                                    cursorColor: Colors.black,
                                    animationDuration:
                                        const Duration(milliseconds: 100),
                                    enableActiveFill: true,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                        controller.currentText = value;
                                    },
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: controller.submitLoading
                                    ? const RoundedLoadingBtn()
                                    : RoundedButton(
                                        text: MyStrings.verify,
                                        press: () {
                                          if (controller
                                                  .currentText.length !=
                                              6) {
                                            controller.hasError = true;
                                          } else {
                                            controller.verifyYourSms(
                                                controller.currentText);
                                          }
                                        }),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      MyStrings.didNotReceiveCode,
                                      style: mulishRegular.copyWith(
                                          fontSize: Dimensions.fontLarge),
                                    ),
                                  ),
                                  Center(
                                    child: controller.resendLoading
                                        ? Container(
                                            margin: const EdgeInsets.all(5),
                                            height: 20,
                                            width: 20,
                                            child:
                                                const CircularProgressIndicator(color: MyColor.primaryColor,))
                                        : GestureDetector(
                                            onTap: () {
                                              controller.sendCodeAgain();
                                            },
                                            child: Text(MyStrings.resend.tr,
                                                style: mulishBold.copyWith(
                                                    fontSize: 16,
                                                    decoration:
                                                        TextDecoration
                                                            .underline,
                                                    color: MyColor
                                                        .primaryColor))),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
