import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/referral_controller/referral_controller.dart';
import 'package:local_coin/data/repo/referral_repo/referral_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/screens/referral/widget/commision_widget.dart';
import 'package:local_coin/view/screens/referral/widget/referred_user_widget.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';
import '../../components/app_bar/custom_appbar.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  void initState() {
    
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReferralRepo(apiClient: Get.find()));
    Get.put(ReferralController(repo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColor.bgColor,
      appBar: CustomAppBar(
        title: MyStrings.referral,
        isShowBackBtn: true,
        bgColor: MyColor.transparentColor,
      ),
      body: GetBuilder<ReferralController>(
          builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenPadding),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (!controller.isCommissionsSelected) {
                              controller.isLoading=true;
                              controller.commissionIndex=0;
                              controller.changeTabMenu();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadiusDirectional.only(
                                    topStart: Radius.circular(Dimensions.cornerRadius),
                                    topEnd: Radius.zero,
                                    bottomStart: Radius.circular(Dimensions.cornerRadius),
                                    bottomEnd: Radius.zero
                                ),
                              color: controller.isCommissionsSelected
                                  ? MyColor.primaryColor
                                  : MyColor.bgColor1,
                            ),
                            child: Text(
                              MyStrings.commissions.tr,
                              style: mulishSemiBold.copyWith(
                                  color: controller.isCommissionsSelected
                                      ? MyColor.colorWhite
                                      : MyColor.colorBlack),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (controller.isCommissionsSelected) {
                              controller.isLoading=true;
                              controller.userIndex=0;
                              controller.changeTabMenu();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:const BorderRadiusDirectional.only(
                                  topStart: Radius.zero,
                                  topEnd:  Radius.circular(Dimensions.cornerRadius),
                                  bottomStart: Radius.zero,
                                  bottomEnd: Radius.circular(Dimensions.cornerRadius)
                              ),
                              color: !controller.isCommissionsSelected
                                  ? MyColor.primaryColor
                                  : MyColor.bgColor1,
                            ),
                            child: Text(
                              MyStrings.referredUsers.tr,
                              style: mulishSemiBold.copyWith(
                                  color: !controller.isCommissionsSelected
                                      ? MyColor.colorWhite
                                      : MyColor.colorBlack),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.isCommissionsSelected
                      ? const CommissionWidget()
                      : const ReferredUserWidget()
                ],
              ))),
    ));
  }
}
