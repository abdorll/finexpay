import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/buttons/status_button.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/show_divider.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/trade_info_column.dart';

import '../../../../../../../core/helper/string_format_helper.dart';
import '../../../../../../../core/utils/my_color.dart';



showTradeInfoSheet(
    BuildContext context
    ) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
           return SizedBox(
             child: DraggableScrollableSheet(
                minChildSize: 0.2,
                initialChildSize: 0.7,
                maxChildSize: 1,
                expand: false,
                builder: (context, scrollController) {
                  return GetBuilder<RunningTradeDetailsController>(builder: (controller)=>
                      Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            const SizedBox(height: 8,),
                            Center(
                              child: Container(
                                height: 5,
                                width: 100,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColor.bgColor1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(MyStrings.instruction.tr,style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge),),
                               CircleButtonWithIcon(
                                 bg: MyColor.bgColor1,
                                 press: (){
                                 Get.back();
                               },iconColor: MyColor.colorBlack,circleSize: 26,iconSize: 20,padding: 6,isIcon: true,isSvg: false,)
                             ],
                           ),
                            const SizedBox(height: 15,),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MyColor.colorWhite,
                                border: Border.all(color: MyColor.borderColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     Text(MyStrings.tradeInformation.tr,style: mulishSemiBold,),
                                     StatusButton( text: controller.getStatus(),
                                       bgColor: controller.getStatusBgColor(),)
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  const CustomDivider(),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: TradeInfoColumn(header: MyStrings.buyerName, body: controller.model.data?.tradeDetails?.buyer?.username??'')),
                                      const SizedBox(width: 10,),
                                      Expanded(child: Align(
                                        alignment: Alignment.bottomRight,
                                          child: TradeInfoColumn(
                                            alignmentEnd: true,
                                              header: MyStrings.sellerName,
                                              body: controller.model.data?.tradeDetails?.seller?.username??''))),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: TradeInfoColumn(header: MyStrings.amount, body: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.model.data?.tradeDetails?.amount ?? '', precision: 8)} ${controller.model.data?.tradeDetails?.fiat?.code}')),
                                      const SizedBox(width: 10,),
                                      Expanded(child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: TradeInfoColumn(
                                            alignmentEnd: true,
                                              header: MyStrings.cryptoAmount, body: '${CustomValueConverter
                                              .twoDecimalPlaceFixedWithoutRounding(
                                              controller.model.data?.tradeDetails
                                                  ?.cryptoAmount ??
                                                  '',
                                              precision: 8)} ${controller.model.data?.tradeDetails?.crypto?.code??''}'),)),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: TradeInfoColumn(header: MyStrings.paymentWindow, body: '${controller.model.data?.tradeDetails?.window ?? ''} ${MyStrings.minutes.tr}',)),
                                      const SizedBox(width: 10,),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: MyColor.colorWhite,
                                  border: Border.all(color: MyColor.borderColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(MyStrings.termsOfTrade.tr,style: mulishSemiBold,),
                                  const SizedBox(height: 10,),
                                  Text(
                                    controller.model.data?.tradeDetails?.advertisement
                                        ?.terms ??
                                        '',
                                    style: robotoLight.copyWith(
                                        color: MyColor.bodyTextColor),
                                  ),
                                  const SizedBox(height: 10,),
                                  const Divider(color: MyColor.borderColor,),
                                  const SizedBox(height: 10,),
                                  Text(MyStrings.paymentDetails.tr,style: mulishSemiBold,),
                                  const SizedBox(height: 10,),
                                  Text(
                                    (controller.model.data?.tradeDetails?.advertisement?.terms ?? '').tr,
                                    style: robotoLight.copyWith(
                                        color: MyColor.bodyTextColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                }),
           );
        });

}

