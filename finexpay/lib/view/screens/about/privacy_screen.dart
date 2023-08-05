import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/screens/about/widget/privacy_shimmer/privacy_shimmer_widget.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';
import '../../../data/controller/privacy/privacy_controller.dart';
import '../../../data/repo/privacy_repo/privacy_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/app_bar/custom_appbar.dart';
import '../../components/buttons/category_button.dart';
import '../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: CustomAppBar(
          title: MyStrings.policies,
          bgColor: MyColor.transparentColor,
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const PrivacyPolicyShimmer())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 30,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              controller.list.length,
                              (index) => Row(
                                children: [
                                  CategoryButton(
                                      color:
                                          controller.selectedIndex == index
                                              ? MyColor.primaryColor
                                              : MyColor.colorGrey2,
                                      horizontalPadding: 8,
                                      verticalPadding: 2,
                                      textSize: Dimensions.fontDefault,
                                      text: controller.list[index]
                                              .dataValues?.title ??
                                          '',
                                      press: () {
                                        controller.changeIndex(index);
                                      }),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                   Expanded( child:  SingleChildScrollView(child: _headerWidget(context, controller.selectedHtml),),)
                  ],
                ),
          ),
        ));
  }

  _headerWidget(BuildContext context, var html) => Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: MyColor.colorWhite,
      child: HtmlWidget(
        html,
        textStyle: mulishRegular.copyWith(color: MyColor.colorBlack),
        onLoadingBuilder: (context, element, loadingProgress) => Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const MyShimmerEffectUI.rectangular(height: 20,width: 120,),
              ),
              const SizedBox(height: 15,),
              const SizedBox(height:100,child: MyShimmerEffectUI.rectangular(height: 100,))
            ],
          ),
        )
      ));
}
