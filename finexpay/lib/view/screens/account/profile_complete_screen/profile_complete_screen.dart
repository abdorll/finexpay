import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/auth/profile_complete_controller.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../data/repo/account/profile_repo.dart';
import '../../../../data/services/api_service.dart';
import 'body.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find(), ));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  const WillPopWidget(
      nextRoute: '',
      child: Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: CustomAppBar(title: MyStrings.profileComplete,isShowBackBtn: true,fromAuth: false,isProfileCompleted: true,),
         body:  Body(),
      ),
    );
  }
}
