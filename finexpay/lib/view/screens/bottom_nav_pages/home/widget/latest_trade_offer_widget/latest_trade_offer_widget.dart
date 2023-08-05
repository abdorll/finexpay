import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/home/home_controller.dart';
import 'package:local_coin/view/components/card_bg.dart';
import 'package:local_coin/view/components/no_data/no_data_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/advertisemetn_widget/advertisement_list_item.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_trade_offer_widget/bottom_sheet.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_trade_offer_widget/trade_offer_shimmer.dart';
import 'package:local_coin/view/screens/transactions/widget/filter_row_widget.dart';

class LatestTradeOfferWidget extends StatelessWidget {
  const LatestTradeOfferWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => RadiusCardShape(
            cardRadius: 4,
            widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyStrings.latestAdvertisement.tr,
                  style: mulishSemiBold,
                ),
                const SizedBox(width: 25,),
                SizedBox(
                  width: 100,
                  child: FilterRowWidget(bgColor:MyColor.transparentColor,text: controller.isBuySelected?MyStrings.buy:MyStrings.sell, press: (){
                    CustomBottomSheet.showTradeSheet([MyStrings.buy.tr,MyStrings.sell.tr], MyStrings.selectAnAdsType, context);
                  }),

                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            controller.isLoading
                ? const AdvertisementShimmer()
                : controller.filteredAdList.isEmpty
                ? Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColor.borderColor)
              ),
              child: const NoDataWidget(
                imageHeight: 100,
               title: MyStrings.noAdvertisementFound,
              ),
            )
                : SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredAdList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AdvertisementListItem(
                      cryptoImagePath:
                      '${UrlContainer.baseUrl}${controller.cryptoImagePath}/${controller.filteredAdList[index].cryptoImage}',
                      gatewayImagePath:
                      '${UrlContainer.baseUrl}${controller.gatewayImagePath}/${controller.filteredAdList[index].fiatGatewayImage}',
                      index: index,
                      ad: controller.filteredAdList[index],
                    );
                  }),
            ),
          ],
        )));
  }
}
