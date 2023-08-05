import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/controller/client_profile_controller/client_profile_controller.dart';
import '../../../components/buttons/circle_button_with_icon.dart';

class BuyAddList extends StatelessWidget {
  const BuyAddList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientProfileController>(
        builder: (controller) => (controller.buyAddList.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: const NoDataOrInternetScreen(
                    message2: MyStrings.emptyAdvertisementLogMsg))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.buyAddList.length + 1,
                itemBuilder: ((context, index) {
                  if (controller.buyAddList.length == index) {
                    return controller.hasNext()
                        ? const Center(
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator(
                                  color: MyColor.primaryColor,
                                )))
                        : const SizedBox();
                  }
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.makeATradeScreen,
                          arguments: controller.buyAddList[index].id);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.cornerRadius),
                          color: MyColor.colorWhite,
                          border:
                              Border.all(color: MyColor.borderColor, width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleButtonWithIcon(
                                      isAsset: false,
                                      isIcon: false,
                                      bg: MyColor.transparentColor,
                                      press: () {},
                                      circleSize: 20,
                                      imageSize: 20,
                                      padding:0,
                                      imagePath:
                                          '${controller.buyAddList[index].userImage}',
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(child: Text(
                                      controller.user?.username ?? '',
                                      style: mulishRegular,
                                    )),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Text(
                                "${MyStrings.window.tr}: ${controller.buyAddList[index].window}",
                                style: robotoRegular.copyWith(
                                    color: MyColor.textColor,
                                    fontSize: Dimensions.fontDefault2),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MyColor.bgColor1),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleButtonWithIcon(
                                      padding: Dimensions.gatewayPadding,
                                      imageSize: Dimensions.gatewayImageSize -
                                          Dimensions.gatewayPadding,
                                      circleSize: Dimensions.gatewayImageSize,
                                      iconSize: 10,
                                      press: () {},
                                      imagePath:
                                          '${UrlContainer.baseUrl}${controller.gatewayImagePath}/${controller.buyAddList[index].fiatGatewayImage}',
                                      bg: Colors.white,
                                      isAsset: false,
                                      isIcon: false,
                                      iconColor: MyColor.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${controller.buyAddList[index].fiatGateway}',
                                      style: mulishRegular,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "${MyStrings.rate.tr}: ${controller.buyAddList[index].rate}\n${controller.buyAddList[index].currency}",
                                    style: robotoRegular,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex:5,
                                  child: Text(
                                "${MyStrings.limit.tr}: ${controller.buyAddList[index].maxLimit}",
                                style: robotoRegular.copyWith(
                                    color: MyColor.colorGrey2,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: Dimensions.fontSmall),
                              )),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "${MyStrings.avg.tr}: ${controller.buyAddList[index].avgSpeed}",
                                  style: robotoRegular.copyWith(
                                      color: MyColor.colorGrey2,
                                      fontSize: Dimensions.fontDefault2),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }))));
  }
}
