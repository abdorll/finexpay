import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/core/utils/styles.dart';

class AdvertisementListWidget extends StatelessWidget {

  final String errorText;
  final String headerText;
  final String svgImage;

  const AdvertisementListWidget({Key? key,
    this.svgImage=MyImages.errorImage,
    this.headerText=MyStrings.tradeLimit,
    this.errorText=MyStrings.tradeLimitMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(35),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.18,),
             SvgPicture.asset(svgImage,height: 80,width: 80,),
             const SizedBox(height: 25,),
            Text(headerText.tr,style: mulishSemiBold.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontLarge),),
            const SizedBox(height: 15,),
            Text(CustomValueConverter.removeQuotationAndSpecialCharacterFromString(errorText).tr,style: robotoRegular.copyWith(color: MyColor.textColor),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
