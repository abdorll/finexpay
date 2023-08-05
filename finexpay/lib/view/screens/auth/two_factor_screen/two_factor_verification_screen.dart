import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/auth/two_factor_controller.dart';
import 'package:local_coin/data/repo/auth/two_factor_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/text/light_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';

class TwoFactorVerificationScreen extends StatefulWidget {

  final bool isProfileCompleteEnable;
  const TwoFactorVerificationScreen({
    Key? key,
    required this.isProfileCompleteEnable
  }) : super(key: key);

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable=widget.isProfileCompleteEnable;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: const CustomAppBar(
            fromAuth: true,
            title: MyStrings.twoFactorAuthentication,
            isShowBackBtn: true,
            isShowActionBtn: false,
            bgColor: Colors.transparent,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<TwoFactorController>(
              builder: (controller) =>  SingleChildScrollView(
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
                            children: const [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: LightText(
                                    text:MyStrings.twoFactorMsg,
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
                                pastedTextStyle: mulishSemiBold.copyWith(color: MyColor.primaryColor400),
                                length: 6,
                                textStyle: mulishSemiBold.copyWith(color: MyColor.colorBlack),
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
                                text:MyStrings.verify,
                                press: () {
                                  if (controller.currentText.length == 6) {
                                    controller.verifyYourSms(controller.currentText);
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 35,
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
      ),
    );
  }
}
