import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../../../../../../data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';

class AlreadyReviewWidget extends StatelessWidget {
  const AlreadyReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: MyColor.warningColor1),
        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
      ),
      child: Text.rich(
       TextSpan(
         text: MyStrings.alreadyAdvertisementGivenMsg.tr,
         style: mulishRegular,
         children: [
          TextSpan(text: ' ${MyStrings.viewReviews.tr}',
          recognizer:TapGestureRecognizer()..onTap=(){
           String adId= Get.find<RunningTradeDetailsController>().model.data?.tradeDetails?.advertisementId??'-1';
            int adsId=int.tryParse(adId)??-1;
            if(adsId>-1){
              Get.toNamed(RouteHelper.makeATradeScreen,arguments: adsId );
            }else{
              CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.somethingWentWrong], msg: [], isError: true);
            }
          },
          style: mulishRegular.copyWith(color: MyColor.warningColor1))
         ]
       )
      ),
    );
  }
}
