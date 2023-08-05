import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/trade/make_a_trade_request_controller/make_a_trade_controller.dart';
import 'package:local_coin/view/components/row_item/icon_with_text.dart';
import 'package:local_coin/view/components/row_item/custom_row.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/make_a_trade_screen/widget/custom_card.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/show_divider.dart';

import '../../../../../../constants/my_strings.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../components/card_bg.dart';
import '../../../../../components/buttons/circle_button_with_icon.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder<MakeATradeController>(builder: (controller)=> Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12,),
        CustomCard(
         headerText: MyStrings.tradeInformation.tr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          CustomRow(firstText: MyStrings.rate, lastText: '${controller.rate} ${controller.ad.fiat?.code??''}/${controller.ad.crypto?.code??''}'),
          CustomRow(firstText: MyStrings.paymentMethod,
              lastText:'',hasChild:true ,
          child: Row(
            children: [
              CircleButtonWithIcon(press: (){},circleSize:25,imageSize:25,padding:0,isIcon: false,isAsset: false,imagePath: '${UrlContainer.baseUrl}assets/images/gateway/${controller.ad.fiatGateway?.image}',),
              const SizedBox(width: 5,),
              Text(controller.ad.fiatGateway?.name??'')
            ],
          ),),
          CustomRow(firstText:MyStrings.tradeLimit,
              lastText: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.ad.min??'0')} - ${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.maxLimit)} ${controller.ad.fiat?.code??''}'),
          CustomRow(firstText: MyStrings.paymentWindow,
            lastText: '${controller.ad.window??'--'} ${MyStrings.minutes.tr}',
            showDivider: false,),
            ],
          ),
        ),
        const SizedBox(height: 12,),
        InkWell(
          onTap: (){
            Get.toNamed(RouteHelper.clientProfileScreen,arguments: controller.ad.user?.username ?? '');
          },
          child: CustomCard(
           headerText: MyStrings.userInformation.tr,
             showMorBtn: true,
             press: (){
               Get.toNamed(RouteHelper.clientProfileScreen,arguments: controller.ad.user?.username ?? '');
             },
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleButtonWithIcon(press: (){},isIcon: false,isAsset: false,circleSize: 25,imageSize: 25,padding: 0,imagePath: controller.getProfileImage(),),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                controller.ad.user?.username??''
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style:mulishRegular.copyWith(fontSize: Dimensions.fontLarge,),
                              ),
                            const SizedBox(height: 4,),
                            Row(
                              children: [
                                IconWithText(text: controller.positiveReview,iconUrl: MyIcons.likeIcon,iconColor: MyColor.greenSuccessColor,),
                                const SizedBox(width: 10,),
                                IconWithText(text: controller.negativeReview,iconUrl: MyIcons.dislikeIcon,iconColor: MyColor.redCancelTextColor,),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          controller.avgSpeed,
                          style: mulishRegular.copyWith(fontSize: Dimensions.fontLarge,),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          MyStrings.avgTradeInformation.tr,
                          style: mulishRegular.copyWith(color: MyColor.textColor,fontSize: Dimensions.fontSmall),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: RadiusCardShape(showBorder:true,cardBgColor:MyColor.bgColor1,margin:4,padding: 5,widget: IconWithText(text: '${MyStrings.email} ',icon:controller.getIcon(controller.ad.user?.ev=='1'?'1':'0'),iconColor: controller.getIconColor(controller.ad.user?.ev=='1'?'1':'0'),iconSize: 18,),cardRadius: 4,)),
                    Expanded(child:RadiusCardShape(showBorder:true,cardBgColor:MyColor.bgColor1,margin:4,padding: 5,widget: IconWithText(text: '${MyStrings.phone} ',icon:controller.getIcon(controller.ad.user?.sv=='1'?'1':'0'),iconColor: controller.getIconColor(controller.ad.user?.sv=='1'?'1':'0'),iconSize: 18,),cardRadius: 4,),),
                    Expanded(child: RadiusCardShape(showBorder:true,cardBgColor:MyColor.bgColor1,margin:4,padding: 5,widget: IconWithText(text: '${MyStrings.id} ',icon:controller.getIcon(controller.ad.user?.kv=='1'?'1':'0'),iconColor:controller.getIconColor(controller.ad.user?.kv=='1'?'1':'0'),iconSize: 18,),cardRadius: 4,),),
                  ],
                ),

              ],
            )),
        ),
        const SizedBox(height: 12,),
        CustomCard(
          headerText: MyStrings.termsOfTrade.tr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDivider(height: 0,bottom: 10,),
              Text(controller.ad.terms??'',style: mulishRegular,)
            ],
          )
        ),
        const SizedBox(height: 12,),
        CustomCard(
            headerText: MyStrings.paymentDetailsOfThisTrade.tr,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDivider(height: 0,bottom: 8,),
                Text(controller.ad.details??'',style: mulishRegular,)
              ],
            )
        ),
        const SizedBox(height: 12,),
      ],
    ));
  }
}
