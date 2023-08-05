import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/components/custom_text_form_field.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/auth/forget_password/forget_password_screen/widget/heading_text_widget.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/route/route.dart';
import '../../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/CustomBackSupportAppbar.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/label_text.dart';
import '../../../../components/rounded_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

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
    Get.put(LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ForgetPasswordController>().isLoading = false;
      Get.find<ForgetPasswordController>().email = '';
    });
  }

  @override
  void dispose() {
    Get.find<ForgetPasswordController>().errors.clear();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Scaffold(
          backgroundColor: MyColor.colorWhite,
          body: GetBuilder<ForgetPasswordController>(
            builder: (controller) => SingleChildScrollView(
              child:  Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomBackSupportAppBar(
                      press: () {
                        Get.offAndToNamed(RouteHelper.loginScreen);
                      },
                      title: MyStrings.forgetPassword,
                    ),
                   Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(header:MyStrings.recoverAccount,body: MyStrings.toRecover.tr),
                           SizedBox(
                            height: MediaQuery.of(context).size.height*.05,
                          ),
                          CustomTextFormField(
                            hintText: MyStrings.enterUserNameOrEmail,
                            isShowBorder: true,
                            isUnderline:true,
                            label: MyStrings.emailOrUserName,
                            isPassword: false,
                            fillColor: MyColor.bgColor1,
                            isShowSuffixIcon: false,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.done,
                            onSuffixTap: () {},
                            onChanged: (value) {
                              controller.email = value;

                              return;
                            },
                            validator: (value) {
                                if (controller.email.isEmpty) {
                                  return MyStrings.enterEmailOrUsername.tr;
                                } else {
                                  return null;
                                }
                            }),
                          const SizedBox(
                            height: 40,
                          ),
                          controller.isLoading
                              ? const RoundedLoadingBtn()
                              : RoundedButton(
                                  press: () {
                                    controller.submitForgetPassCode();
                                  },
                                  text: MyStrings.submit,
                                ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
