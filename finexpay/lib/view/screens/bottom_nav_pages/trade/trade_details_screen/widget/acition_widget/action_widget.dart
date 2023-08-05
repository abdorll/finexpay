import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/buttons/status_button.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/buyer_btn_and_message_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/review_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/seller_btn_and_message_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/show_divider.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/trade_info_bottom_sheet.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/styles.dart';
import 'already_review_widget.dart';

class ActionWidget extends StatefulWidget {
  const ActionWidget({Key? key}) : super(key: key);

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RunningTradeDetailsController>(
        builder: (controller) => RefreshIndicator(
              color: MyColor.primaryColor,
              backgroundColor: MyColor.colorWhite,
              onRefresh: () async {
                await controller.onRefresh();
              },
              child: SizedBox(
                child: ListView(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColor.transparentColor,
                            border: Border.all(color: MyColor.borderColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '#${controller.tradeNumber}',
                                    style: mulishRegular,
                                  ),
                                 StatusButton(text: controller.getStatus(), bgColor: controller.getStatusBgColor())
                                ],
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 5,),
                            Text(
                              controller.isBuyer
                                  ? controller.model.data?.buyerHeading ?? ''
                                  : controller.model.data?.sellerHeading ?? '',
                              style: mulishRegular.copyWith(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.model.data?.subHeading ?? '',
                              style: robotoRegular.copyWith(
                                  color: MyColor.primaryColor),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Divider(
                              color: MyColor.borderColor,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            controller.getStatusId() == '0'
                                ? SizedBox(
                                    child: controller.isBuyer
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    color: MyColor.redCancelTextColor
                                                        .withOpacity(0.1),
                                                    border: Border.all(
                                                        color: MyColor.redCancelTextColor,
                                                        width: .5)),
                                                child: Text(
                                                  controller.model.data
                                                          ?.buyerMszOne ??
                                                      '',
                                                  style: mulishRegular.copyWith(
                                                    fontSize: 14,
                                                     color: MyColor.redCancelTextColor
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              const Divider(
                                                color: MyColor.borderColor,
                                                height: 1,
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                controller.model.data
                                                        ?.buyerMszTwo ??
                                                    '',
                                                style: robotoRegular,
                                              ),
                                              const CustomDivider()
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text(
                                                controller.model.data
                                                        ?.sellerMszOne ??
                                                    '',
                                                style: mulishRegular,
                                              ),
                                              const CustomDivider()
                                            ],
                                          ),
                                  )
                                : const SizedBox(),
                            controller.getStatusId() == '8'
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: MyColor.redCancelTextColor
                                            .withOpacity(0.1),
                                        border: Border.all(
                                            color: MyColor.redCancelTextColor,
                                            width: .5)),
                                    child: Text(
                                      controller.model.data?.reportedMsz ?? '',
                                      style: mulishRegular.copyWith(
                                          color: MyColor.redCancelTextColor),
                                    ),
                                  )
                                : controller.isBuyer
                                    ? controller.getStatusId().isNotEmpty &&
                                            controller.getStatusId() != '1' &&
                                            controller.getStatusId() != '9'
                                        ? BuyerBtnAndMessageWidget(
                                            status: controller.getStatusId())
                                        : const SizedBox()
                                    : controller.getStatusId().isNotEmpty &&
                                            controller.getStatusId() != '1' &&
                                            controller.getStatusId() != '9'
                                        ? SellerBtnAndMessageWidget(
                                            status: controller.getStatusId())
                                        : const SizedBox(),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                                onTap: () {
                                  showTradeInfoSheet(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: MyColor.borderColor)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.info_outline,
                                            size: 22,
                                            color: MyColor.colorGrey,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(
                                            MyStrings.instructionToBeFollowed.tr,
                                            style: mulishSemiBold,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.expand_more_outlined,
                                        size: 22,
                                        color: MyColor.colorGrey,
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.isShowReview ? const ReviewWidget() : controller.alreadyReviewed?const AlreadyReviewWidget():const SizedBox()
                    ]),
              ),
            ));
  }
}
