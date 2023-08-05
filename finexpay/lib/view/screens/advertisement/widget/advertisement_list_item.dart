import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/advertisement/MainAdvertisementResponseModel.dart';
import 'package:local_coin/view/components/buttons/try_type_btn.dart';
import 'package:local_coin/view/screens/advertisement/widget/unpublished_bottom_sheet.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../components/buttons/circle_button_with_icon.dart';
import '../../../components/buttons/status_button.dart';
import 'advertisement_edit_bottom_sheet.dart';

class AdvertisementListItem extends StatelessWidget {
  final int index;
  final String cryptoImagePath;
  final String gatewayImagePath;
  final Ads ad;

  const AdvertisementListItem({Key? key,
    required this.cryptoImagePath,
    required this.index,
    required this.ad,
    required this.gatewayImagePath,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActive = ad.status?.toLowerCase() == MyStrings.enabled.toLowerCase();
    Color statusColor = ad.status?.toLowerCase() == MyStrings.enabled.toLowerCase()
        ? MyColor.greenSuccessColor
        : MyColor.redCancelTextColor;

    return InkWell(
      onTap: () {
          showEditAdvertisementBottomSheet(
              context, true, ad.id ?? -1, status: isActive);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
            border: Border.all(color: MyColor.borderColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(children: [
                      CircleButtonWithIcon(
                        isIcon: false,
                        isAsset: false,
                        press: () {},
                        imagePath: cryptoImagePath,
                        padding: 2,
                        bg: MyColor.colorWhite,
                        imageSize: Dimensions.cryptoImageSize,
                        circleSize: Dimensions.cryptoImageSize+2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${ad.cryptoCode}",
                        style: mulishRegular,
                      ),

                    ])),

                TrxTypeBtn(
                  text: ad.type.toString(),
                  bgColor: ad.type?.toLowerCase() == MyStrings.buy.toLowerCase()
                      ? MyColor.primaryColor
                      : MyColor.secondaryColor,
                )


              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${MyStrings.window.tr}: ${ad.window}",
                  style: robotoRegular.copyWith(color: MyColor.textColor),
                ),
                GestureDetector(
                  onTap: (){
                    if(ad.publish.toString()=='0'){
                      showUnpublishedSheet(context, ad.unpublishReason??[]);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ad.publish.toString()=='0'?MyColor.redCancelTextColor:MyColor.greenSuccessColor),
                        color:ad.publish.toString()=='0'?MyColor.redCancelTextColor.withOpacity(.1):MyColor.greenSuccessColor.withOpacity(.1)
                    ),
                    child: Row(
                      children: [
                        ad.publish.toString()=='0'?const Icon(Icons.info,color: MyColor.redCancelTextColor,size: 15,): const SizedBox(),
                        ad.publish.toString()=='0'?const SizedBox(width: 5,): const SizedBox(),
                        Text( ad.publish.toString()=='0'?MyStrings.unpublished.tr:MyStrings.published.tr,style: mulishRegular.copyWith(fontSize:Dimensions.fontSmall,color: ad.publish.toString()=='0'?MyColor.redCancelTextColor:MyColor.greenSuccessColor),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:3,
                    child: Row(
                      children: [
                        CircleButtonWithIcon(
                          press: () {},
                          isIcon: false,
                          isAsset: false,
                          imagePath: gatewayImagePath,
                          bg: MyColor.colorWhite,
                          padding: Dimensions.gatewayPadding,
                          imageSize: Dimensions.gatewayImageSize-Dimensions.gatewayPadding,
                          circleSize: Dimensions.gatewayImageSize,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            "${ad.fiatGateway}",
                            style: mulishRegular,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${MyStrings.rate.tr}: ${ad.rate ?? '0'}\n${ad.rateCurrency}",
                            style: robotoRegular,
                            textAlign: TextAlign.end,
                          ))),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "${ad.fixedMargin}",
                  style: robotoRegular,
                ),
                StatusButton(text: ad.status ?? '', bgColor: statusColor)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
