
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/text/light_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../core/utils/my_color.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/auth/email_verification_controller.dart';
import '../../../../data/repo/auth/general_setting_repo.dart';
import '../../../../data/repo/auth/sms_email_verification_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/rounded_button.dart';



class EmailVerificationScreen extends StatefulWidget {
  final bool needSmsVerification;
  final bool isProfileCompleteEnabled;
  final bool needTwoFactor;
  const EmailVerificationScreen({Key? key,
    required this.needSmsVerification,
    required this.isProfileCompleteEnabled,
    required this.needTwoFactor
  })
      : super(key: key);


  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    final controller = Get.put(EmailVerificationController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.needSmsVerification = widget.needSmsVerification;
      controller.isProfileCompleteEnable = widget.isProfileCompleteEnabled;
      controller.needTwoFactor = widget.needTwoFactor;
      controller.loadData();
    });
  }

  @override
  void dispose() {
    Get.find<EmailVerificationController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<EmailVerificationController>().needSmsVerification =
        widget.needSmsVerification;
    return const PinCodeVerificationScreen();
  }
}

class PinCodeVerificationScreen extends StatefulWidget {

  const PinCodeVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  // snackBar Widget


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const CustomAppBar(fromAuth:true,title: MyStrings.emailVerification,isShowBackBtn: true,isShowActionBtn: false,bgColor: Colors.transparent,),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<EmailVerificationController>(
              builder: (controller) => controller.dataLoading
                  ? const Center(child: CircularProgressIndicator(color: MyColor.primaryColor,))
                  : Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 35,),
                        Center(
                          child: Image.asset(MyImages.emailLogo,height: 120,width: 120,fit: BoxFit.cover,),
                        ),
                        const SizedBox(height: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8),
                              child: LightText(text: MyStrings.weHaveSentEmailVerificationCode,isAlignCenter: true,
                            )),

                          ],
                        ),
                        const SizedBox(height: 17),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: mulishSemiBold.copyWith(
                                  color: MyColor.primaryColor400),
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
                          child: controller.submitLoading
                              ? const RoundedLoadingBtn()
                              : RoundedButton(
                              text: MyStrings.verify.tr,
                              press: () {
                                if (controller.currentText.length != 6) {
                                } else {
                                  controller.verifyEmail(controller.currentText);
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 35,
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
                              child:  controller.resendLoading? Container(margin: const EdgeInsets.all(5),height:20,width:20,child: const CircularProgressIndicator(color: MyColor.primaryColor,)):GestureDetector(
                                  onTap: () {
                                    controller.sendCodeAgain();
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
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}

