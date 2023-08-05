import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/screens/lock_screen/widget/flutter_screen_lock.dart';

class CreateNewPinScreen extends StatefulWidget {
  const CreateNewPinScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPinScreen> createState() => _CreateNewPinScreenState();
}

class _CreateNewPinScreenState extends State<CreateNewPinScreen> {

  @override
  void initState() {
    super.initState();
  }
  final controller = InputController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ScreenLock.create(
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1,vertical: 12),
              child: Text(MyStrings.enterYourNewPassCode.tr,),
            ),
            confirmTitle: Text(MyStrings.confirmNewPassCode.tr),
            inputController: controller,
            footer: TextButton(
              onPressed: () {
                controller.unsetConfirmed();
              },
              child: Text(MyStrings.resetInput.tr,style: mulishSemiBold,),
            ),
            onConfirmed: (String value) async{
            final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
            await apiClient.sharedPreferences.setString(SharedPreferenceHelper.screenLockPin, value);
            Get.offAndToNamed(RouteHelper.homeScreen);
          },),
        ),
      ),
    );
  }
}
