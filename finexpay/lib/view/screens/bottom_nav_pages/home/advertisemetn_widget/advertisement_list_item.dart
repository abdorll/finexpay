import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/components/buttons/status_button.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/model/dashboard/DashboardResponseModel.dart';
import '../../../../components/buttons/circle_button_with_icon.dart';


class AdvertisementListItem extends StatelessWidget {
  final int index;
  final Ads ad;
  final String gatewayImagePath;
  final String cryptoImagePath;

  const AdvertisementListItem(
      {Key? key,
        required this.ad,
        required this.index,
        required this.cryptoImagePath,
        required this.gatewayImagePath,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color statusColor = ad.status?.toLowerCase()==MyStrings.enabled.toLowerCase()?MyColor.greenSuccessColor:MyColor.redCancelTextColor;

    return Container(
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
                  padding: 0,
                  bg: MyColor.colorWhite,
                  imageSize: 22,
                  circleSize: 22,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "${ad.cryptoCode}",
                  style: mulishRegular,
                ),
              ])),
              Text(
                "${ad.fixedMargin}",
                style: robotoRegular,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColor.bgColor1,width: 1),
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
                        padding: Dimensions.gatewayPadding,
                        bg: MyColor.colorWhite,
                        imageSize: Dimensions.gatewayImageSize-Dimensions.gatewayPadding,
                        circleSize: Dimensions.gatewayImageSize,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(child:Text(
                        "${ad.fiatGateway}",
                        style: mulishRegular,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "${MyStrings.rate.tr}: ${ad.rate??'0'}\n${ad.rateCurrency}",
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
                "${MyStrings.window.tr} ${ad.window}",
                style: robotoRegular.copyWith(color: MyColor.secondaryColor),
              ),
              StatusButton(text: ad.status??'', bgColor: statusColor)
            ],
          ),
        ],
      ),
    );
  }


}
