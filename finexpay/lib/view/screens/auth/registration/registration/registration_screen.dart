
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/auth/registration/registration/widget/heading_text_widget.dart';
import 'package:local_coin/view/screens/auth/registration/registration/widget/input_widget.dart';
import 'package:local_coin/view/screens/auth/registration/registration/widget/registration_shimmer.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/route/route.dart';
import '../../../../../data/controller/auth/auth/registration_controller.dart';
import '../../../../../data/repo/auth/general_setting_repo.dart';
import '../../../../../data/repo/auth/signup_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/CustomBackSupportAppbar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child:  GetBuilder<RegistrationController>(
          builder: (controller) => SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bgColor,
            body: controller.noInternet?NoDataOrInternetScreen(isNoInternet: true,onChanged: (value){
              controller.changeNotification(value);
            },): ListView(
              children: [
                CustomBackSupportAppBar(
                  press: () {
                    Get.find<RegistrationController>().clearAllData();
                    Get.offAndToNamed(RouteHelper.loginScreen);
                  },
                  title: MyStrings.signUp,
                ),
               controller.isCountryLoading
                      ? const RegistrationShimmer()
                      :  SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [HeadingTextWidget(), InputWidget()],
                          ),
                        ),

              ],
            ),
          ),
        ),
      )),
    );
  }
}
