import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/data/controller/localization/localization_controller.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';

import '../../../data/controller/splash_controller.dart';
import '../../../data/repo/auth/general_setting_repo.dart';
import '../../../data/services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(),localizationController: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: MyColor.primaryColor,
          statusBarColor: MyColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light));
     controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: MyColor.colorGrey3,
      statusBarColor: MyColor.primaryColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:Brightness.light ,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (controller) => Scaffold(
      backgroundColor: controller.noInternet?MyColor.colorWhite:MyColor.primaryColor,
      body:controller.noInternet?SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: NoDataOrInternetScreen(isNoInternet: true,onChanged: (value){
          if(value){
            controller.gotoNextPage();
          }
        },),
      ): Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            Image.asset(
            MyImages.logo,
            height: 150,
            width: 150,
             )
            ],
          ),
        ))
      );
  }
}
