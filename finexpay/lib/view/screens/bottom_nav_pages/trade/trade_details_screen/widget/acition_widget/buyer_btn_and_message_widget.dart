
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/countdown_timer.dart';

import '../../../../../../components/dialog/warning_dialog.dart';

class BuyerBtnAndMessageWidget extends StatefulWidget {
  final String status;

  const BuyerBtnAndMessageWidget({Key? key, required this.status})
      : super(key: key);

  @override
  State<BuyerBtnAndMessageWidget> createState() =>
      _BuyerBtnAndMessageWidgetState();
}

class _BuyerBtnAndMessageWidgetState extends State<BuyerBtnAndMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RunningTradeDetailsController>(builder: (controller) {
      return widget.status == '0'
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              (controller.getRemainingMin() < 1
                                  ? controller.model.data?.buyerCancelMsz ?? ''
                                  : controller.model.data?.buyerCancelMsz ?? '').tr,
                              style: mulishRegular,
                            ),
                          ),
                          SizedBox(
                            width: controller.getRemainingMin() > 0 ? 15 : 0,
                          ),
                          controller.getRemainingMin() > 0
                              ? CountDownTimer(
                                  onEnd: () {
                                    controller.changeRemMin();
                                  },
                                  remMin: controller.getRemainingMin())
                              : const SizedBox(
                                  width: 1,
                                )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: controller.buyerOrSellerBtnLoading &&
                                  controller.clickOn == 2
                              ?const RoundedLoadingBtn(
                                  horizontalPadding: 15,
                                  verticalPadding: 13,
                                  color: MyColor.redCancelTextColor,
                                )
                              : RoundedButton(
                                  horizontalPadding: 15,
                                  verticalPadding: 13,
                                  text: MyStrings.cancel_.tr,
                                  press: () {
                                    MyDialog(MyStrings.areYouSureCancelThisTrade, press:(){
                                      Get.back();
                                      controller.buyerButtonAction(2);
                                    }).showAlertDialog(context);
                                  },
                                  color: MyColor.redCancelTextColor,
                                )),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                          child: controller.buyerOrSellerBtnLoading &&
                                  controller.clickOn == 1
                              ? const RoundedLoadingBtn(
                            horizontalPadding: 15,
                            verticalPadding: 13,
                            color: MyColor.greenSuccessColor,
                          )
                              : RoundedButton(
                                  horizontalPadding: 15,
                                  verticalPadding: 13,
                                  text: MyStrings.iHavePaid,
                                  press: () {
                                    MyDialog(MyStrings.areYourSureThatYourHavePaidTheAmount, press:(){
                                      Get.back();
                                      controller.buyerButtonAction(1);
                                    }).showAlertDialog(context);
                                  },
                                  color: MyColor.greenSuccessColor,
                                )),
                    ],
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.getRemainingMin() > 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              (controller.model.data?.buyerDisputeMsz ?? '').tr,
                              style: mulishRegular,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          CountDownTimer(
                              onEnd: () {
                                controller.changeRemMin();
                              },
                              remMin: controller.getRemainingMin())
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: controller.buyerOrSellerBtnLoading &&
                                      controller.clickOn == 3
                                  ? const RoundedLoadingBtn(
                                horizontalPadding: 15,
                                verticalPadding: 13,
                                color: MyColor.closeRedColor,
                              )
                                  : RoundedButton(
                                      horizontalPadding: 15,
                                      verticalPadding: 13,
                                      text: MyStrings.dispute,
                                      press: () {
                                        MyDialog(MyStrings.areYouSureDisputeThisTrade, press:(){
                                          Get.back();
                                          controller.buyerButtonAction(3);
                                        }).showAlertDialog(context);

                                      },
                                      color: MyColor.closeRedColor,
                                    )),
                        ],
                      ),
              ],
            );
    });
  }
}
