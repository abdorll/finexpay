import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/menu/my_menu_controller.dart';
import 'package:local_coin/data/repo/menu_repo/menu_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';

import '../widget/flutter_screen_lock.dart';

class VerifyLockPinScreen extends StatefulWidget {
  const VerifyLockPinScreen({Key? key}) : super(key: key);

  @override
  State<VerifyLockPinScreen> createState() => _VerifyLockPinScreenState();
}

class _VerifyLockPinScreenState extends State<VerifyLockPinScreen> {

  @override
  void initState() {
    Get.put(MenuRepo(apiClient: Get.find()));
    final controller = Get.put(MyMenuController(repo: Get.find()));
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadPin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMenuController>(builder: (controller)=>
        Scaffold(
          body: controller.screenPin.isEmpty? const Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator()),):
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
            child: ScreenLock(
                correctString: controller.screenPin,
                maxRetries: 3,
                title: Text(MyStrings.enterYourPINCode.tr,style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge),),
                retryDelay: const Duration(seconds: 15),
                cancelButton: controller.logoutLoading?const SizedBox(height:30,width:30,child: CircularProgressIndicator()):GestureDetector(
                  onTap: (){
                    controller.logout();
                  }, child: Text(MyStrings.logout.tr,style: mulishRegular,)),
                onCancelled: (){
                  controller.logout();
                },
                onUnlocked: Navigator.of(context).pop,
               ),
          ),
        )));
  }
}
