import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_icons.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../data/controller/trade/make_a_trade_request_controller/make_a_trade_controller.dart';
import '../../../../../components/custom_rounded_icon_button.dart';
import '../../../../../components/custom_text_field.dart';
import '../../../../../components/rounded_button.dart';

void showReviewDialog(int index,BuildContext context,String text){

  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return GetBuilder<MakeATradeController>(builder: (controller){
          controller.reviewFeedbackController.text=text;
          return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10,bottom: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child:  Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          MyStrings.updateReview.tr,
                          style: mulishBold.copyWith(
                              fontSize: Dimensions.fontLarge),
                        ),
                        const SizedBox(width: 10,),
                        CustomRoundedIconButton(color:MyColor.colorWhite,iconColor:MyColor.colorGrey2,press: () {
                          controller.reviewFeedbackController.text='';
                          controller.isReviewUpdating=false;
                          Get.back();
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if(!controller.isUpdateReviewPositive){
                              controller.updateReviewType(true);
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                controller.isUpdateReviewPositive?MyIcons.likeIcon:MyIcons.likeOutlinedIcon,
                                color: controller.isUpdateReviewPositive?MyColor.greenSuccessColor:MyColor.colorGrey2,
                                height:13,
                                width:13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                               MyStrings.positive.tr,
                                style: robotoRegular,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            if(controller.isUpdateReviewPositive){
                              controller.updateReviewType(false);
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                controller.isUpdateReviewPositive?MyIcons.dislikeOutlinedIcon:MyIcons.dislikeIcon,
                                color:  controller.isUpdateReviewPositive?MyColor.colorGrey2:MyColor.redCancelTextColor,
                                height: 13,
                                width: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                MyStrings.negative.tr,
                                style: robotoRegular,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                    CustomTextField(
                        hintText: MyStrings.yourFeedback,
                        controller: controller.reviewFeedbackController,
                        maxLines: 5,
                        onChanged: (value){

                        }),
                    const SizedBox(height: 25,),
                    Center(
                        child:controller.isReviewUpdating?const RoundedLoadingBtn():RoundedButton(
                          press: () async{
                            FocusManager.instance.primaryFocus?.unfocus();
                            await controller.updateReview(index);
                            Get.back();
                          },
                          text: MyStrings.update,
                        )),
                    const SizedBox(height: 15,),
                  ],
                ),
              ));
         }
        );


      });

}