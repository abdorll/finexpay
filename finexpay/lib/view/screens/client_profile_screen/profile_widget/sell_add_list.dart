import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/client_profile_controller/client_profile_controller.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../components/CustomNoDataFoundClass.dart';
import '../../../components/buttons/circle_button_with_icon.dart';

class SellAddListWidget extends StatelessWidget {
  const SellAddListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientProfileController>(builder: (controller)=>
    controller.sellAddList.isEmpty?SizedBox(height:MediaQuery.of(context).size.height,width:Get.width,child: const NoDataOrInternetScreen(message2: MyStrings.emptyAdvertisementLogMsg,)):ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.sellAddList.length+1,
        itemBuilder: ((context, index) {

          if (controller
              .sellAddList.length ==
              index) {
            return controller.hasNext()
                ? const Center(
                child:
                CircularProgressIndicator(color: MyColor.primaryColor,))
                : const SizedBox();
          }

          return GestureDetector(
            onTap: (){
              Get.toNamed(
                  RouteHelper.makeATradeScreen,
                  arguments: controller
                      .sellAddList[index]
                      .id);
            },
            child: Container(
              margin:
              const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      Dimensions.cornerRadius),
                  color: MyColor.colorWhite,
                  border: Border.all(
                      color: MyColor.borderColor,
                      width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleButtonWithIcon(isAsset: false,isIcon: false,bg: MyColor.bgColor1,
                              press: (){},
                              circleSize: 20,
                              imageSize: 20,
                              padding: 0,
                              imagePath: '${controller.sellAddList[index].userImage}',),
                            const SizedBox(width: 5,),
                            Flexible(
                              child: Text(
                               controller.user?.username??'',
                                style: mulishRegular,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Text(
                        "${MyStrings.window.tr}: ${controller.sellAddList[index].window}",
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
                        borderRadius:
                        BorderRadius.circular(
                            4),
                        color: MyColor.bgColor1),
                    padding:
                    const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleButtonWithIcon(
                              padding: Dimensions.gatewayPadding,
                              imageSize: Dimensions.gatewayImageSize-Dimensions.gatewayPadding,
                              circleSize: Dimensions.gatewayImageSize,
                              iconSize: 10,
                              press: () {},
                              imagePath: '${UrlContainer.baseUrl}${controller.gatewayImagePath}/${controller.sellAddList[index].fiatGatewayImage}',
                              bg: Colors.white,
                              isAsset: false,
                              isIcon: false,
                              iconColor: MyColor
                                  .primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                             Text(
                              controller.sellAddList[index].fiatGateway??'',
                              style: mulishRegular,
                            ),
                          ],
                        ),
                        Text(
                          "${MyStrings.rate.tr}: ${controller.sellAddList[index].rate}\n${controller.sellAddList[index].currency}",
                          style: robotoRegular,
                          textAlign: TextAlign.end,
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
                            "${MyStrings.limit.tr}: ${controller.sellAddList[index].maxLimit}",
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
                          "${MyStrings.avg.tr}: ${controller.sellAddList[index].avgSpeed}",
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
        })));
  }
}
