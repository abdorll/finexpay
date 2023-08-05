

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/home/home_controller.dart';
import 'package:local_coin/view/components/card_bg.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_result_widget/latest_result_shimmer.dart';

import 'latest_result_list_item.dart';

class LatestResultWidget extends StatelessWidget {
  const LatestResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading
            ? const LatestResultShimmer()
            : RadiusCardShape(
            cardRadius: 4,
            widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(MyStrings.tradeSummary.tr,style: mulishSemiBold),
            const SizedBox(height: 12,),
            Row(
              children: [
                Expanded(
                    child: LatestResultListItem(
                      bgColor: MyColor.card3,
                      text: MyStrings.running.tr,
                      icon:MyIcons.runningIcon,
                      quantity:  controller.runningTrade ?? '0',)),
                const SizedBox(
                  width: 12,
                ),

                Expanded(
                    child: LatestResultListItem(
                      bgColor: MyColor.card1,
                      text:  MyStrings.completed.tr,
                      icon: MyIcons.completedIcon,
                      quantity: controller.completedTrade ?? '0',)),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(MyStrings.addSummary.tr,style: mulishSemiBold),
            const SizedBox(height: 12,),
            Row(
              children: [
                Expanded(
                    child: LatestResultListItem(
                        bgColor: MyColor.card2,
                        text: MyStrings.buyAds.tr,
                        icon: MyIcons.buyIcon,
                        quantity:  controller.buyAdd??'0',)),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: LatestResultListItem(
                    bgColor: MyColor.card,
                    text:  MyStrings.sellAds.tr,
                    icon: MyIcons.sellIcon,
                    quantity: controller.sellAdd??'0'))
              ],
            ),
          ],
        )));
  }
}
