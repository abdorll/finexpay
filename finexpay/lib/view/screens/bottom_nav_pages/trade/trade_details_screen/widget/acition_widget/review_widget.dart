import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/my_icons.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../components/custom_text_field.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({Key? key}) : super(key: key);

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RunningTradeDetailsController>(builder: (controller){
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: MyColor.borderColor)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(MyStrings.howWastTradingExperience.tr,style: mulishSemiBold,),
            const SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.changeReview(true);
                      },
                      child: Row(
                        children: [
                      SvgPicture.asset(
                        controller.isPositive&&!controller.isFirst?MyIcons.likeIcon:MyIcons.likeOutlinedIcon,
                        color: controller.isPositive&&!controller.isFirst?MyColor.greenSuccessColor:MyColor.colorBlack,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          MyStrings.positive.tr,
                          style: robotoRegular.copyWith(color:controller.isPositive&&!controller.isFirst?MyColor.greenSuccessColor:MyColor.colorBlack )
                      )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        controller.changeReview(false);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            controller.isPositive?MyIcons.dislikeOutlinedIcon:MyIcons.dislikeIcon,
                            color: controller.isPositive?MyColor.colorBlack:MyColor.red,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            MyStrings.negative.tr,
                            style: robotoRegular.copyWith(color:controller.isPositive?MyColor.colorBlack:MyColor.red ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      CustomTextField(
                        maxLines: 5,
                          controller: controller.reviewController,
                          onChanged: (value) {}),

                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                controller.reviewBtnLoading?const RoundedLoadingBtn():RoundedButton(text: controller.isUpdate?MyStrings.updateReview.tr:MyStrings.publishReview.tr, press: (){
                  controller.storeReview(controller.isPositive?"1":"0").then((value){
                    if(value){
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }
                  });
                }),

              ],
            )
          ],
        ),
      );
    });
  }
}
