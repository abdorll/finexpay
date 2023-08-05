
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/dialog/warning_dialog.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/countdown_timer.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../components/rounded_button.dart';

class SellerBtnAndMessageWidget extends StatefulWidget {
  final String status;

  const SellerBtnAndMessageWidget({Key? key, required this.status})
      : super(key: key);

  @override
  State<SellerBtnAndMessageWidget> createState() =>
      _SellerBtnAndMessageWidgetState();
}

class _SellerBtnAndMessageWidgetState extends State<SellerBtnAndMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RunningTradeDetailsController>(
        builder: (controller) => widget.status == '0'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.getRemainingMin() > 1
                      ? Row(
                          children: [
                            Expanded(
                                child: Text(
                                    controller.model.data?.sellerCancelMsz ??
                                        "",
                                    style: robotoRegular)),
                            const SizedBox(
                              width: 15,
                            ),
                            CountDownTimer(onEnd:(){
                             controller.changeRemMin();
                            },remMin: controller.getRemainingMin())
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: controller.buyerOrSellerBtnLoading &&
                                        controller.clickOn == 1
                                    ?const RoundedLoadingBtn(
                                    horizontalPadding: 15,
                                    verticalPadding: 13,
                                    color: MyColor.redCancelTextColor,
                                    )
                                    : RoundedButton(
                                    horizontalPadding: 15,
                                    verticalPadding: 13,
                                        color: MyColor.redCancelTextColor,
                                        text: 'Cancel',
                                        press: () {
                                      MyDialog(MyStrings.areYouSureCancelThisTrade, press:(){
                                        Get.back();
                                        controller.sellerButtonAction(1);
                                      }).showAlertDialog(context);

                                        }),
                              ),
                            )
                          ],
                        ),
                ],
              )
            : widget.status == '2'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.getRemainingMin() > 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller
                                                .model.data?.sellerDisputeMsz ??
                                            '',
                                        style: mulishRegular,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    CountDownTimer(onEnd:(){
                                         controller.changeRemMin();
                                    }, remMin: controller.getRemainingMin())
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: controller
                                            .buyerOrSellerBtnLoading &&
                                            controller.clickOn == 3
                                            ? const RoundedLoadingBtn(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          color:
                                          MyColor.closeRedColor,
                                        )
                                            : RoundedButton(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          text: 'Dispute',
                                          press: () {
                                            MyDialog(MyStrings.areYouSureDisputeThisTrade, press:(){
                                              Get.back();
                                              controller
                                                  .sellerButtonAction(3);
                                            }).showAlertDialog(context);

                                          },
                                          color:
                                          MyColor.closeRedColor,
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: controller
                                            .buyerOrSellerBtnLoading &&
                                            controller.clickOn == 2
                                            ? const RoundedLoadingBtn(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          color:
                                          MyColor.greenSuccessColor,
                                        )
                                            : RoundedButton(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          text: 'Release',
                                          press: () {
                                            MyDialog(MyStrings.areYouSureReleaseThisTrade, press: (){
                                              Get.back();
                                              controller
                                                  .sellerButtonAction(2);
                                            }).showAlertDialog(context);

                                          },
                                          color:
                                          MyColor.greenSuccessColor,
                                        )),

                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  controller.model.data?.sellerDisputeMsz ?? '',
                                  style: mulishRegular,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: controller
                                            .buyerOrSellerBtnLoading &&
                                            controller.clickOn == 3
                                            ?const RoundedLoadingBtn(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          color:
                                          MyColor.closeRedColor,
                                        )
                                            : RoundedButton(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          text: 'Dispute',
                                          press: () {
                                            MyDialog(MyStrings.areYouSureDisputeThisTrade, press: (){
                                              Get.back();
                                              controller
                                                  .sellerButtonAction(3);
                                            }).showAlertDialog(context);
                                          },
                                          color:
                                          MyColor.closeRedColor,
                                        )),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                        child: controller
                                            .buyerOrSellerBtnLoading &&
                                            controller.clickOn == 2
                                            ? const RoundedLoadingBtn(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          color:
                                          MyColor.greenSuccessColor,
                                        )
                                            : RoundedButton(
                                          cornerRadius: 8,
                                          horizontalPadding: 15,
                                          verticalPadding: 13,
                                          text: MyStrings.release,
                                          press: () {

                                            MyDialog(MyStrings.areYouSureReleaseThisTrade, press: (){
                                              Get.back();
                                              controller
                                                  .sellerButtonAction(2);
                                            }).showAlertDialog(context);
                                          },
                                          color:
                                          MyColor.greenSuccessColor,
                                        )),
                                  ],
                                ),
                              ],
                            )
                    ],
                  )
                : const SizedBox());
  }
}
