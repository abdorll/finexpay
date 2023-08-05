import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/home/home_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/wallet_widget/wallet_shimmer/wallet_shimmer.dart';

import '../../../../../../core/route/route.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller)=>
     controller.isLoading?const WalletShimmerWidget():
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              controller.walletList.length, (index){
            return InkWell(

              onTap: (){
                Get.toNamed(RouteHelper.singleWalletTransaction,arguments:controller.walletList[index].cryptoId.toString());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                       margin: EdgeInsets.zero,
                       elevation: 1,
                        shadowColor: MyColor.bgColor,
                        shape: Border.all(color: MyColor.borderColor,width: .5),
                        color: MyColor.colorWhite,
                       // borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleButtonWithIcon(press: (){},isIcon:false,padding:0,isAsset:false,circleSize:35,imageSize: 35,borderColor: MyColor.borderColor,imagePath:"${UrlContainer.baseUrl}${controller.cryptoImagePath}/${controller.walletList[index].image}",),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.walletList[index].cryptoCode??'',style: mulishRegular.copyWith(fontSize: Dimensions.fontDefault),),
                                    Text(controller.walletList[index].balance??'0.00',style: mulishSemiBold.copyWith(color: MyColor.primaryColor,fontSize: Dimensions.fontLarge),),
                                    const SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text("${MyStrings.inUSD.tr} ",style: mulishRegular.copyWith(color: MyColor.primaryColor,fontSize: Dimensions.fontSmall),),
                                        const Icon(Icons.arrow_forward,color: MyColor.primaryColor,size: 13,),
                                        Text(" ${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.walletList[index].balanceInUSD??'0.00')}",style: mulishRegular.copyWith(color: MyColor.primaryColor,fontSize: Dimensions.fontSmall),)
                                      ],
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
            );
          }),
      ),
    ),
        ));
  }
}
