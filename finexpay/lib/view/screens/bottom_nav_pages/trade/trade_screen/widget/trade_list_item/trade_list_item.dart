import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/components/buttons/status_button.dart';
import 'package:local_coin/view/components/buttons/try_type_btn.dart';

import '../../../../../../../core/utils/dimensions.dart';
import '../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../components/buttons/circle_button_with_icon.dart';


class TradeListItem extends StatefulWidget {
  final Callback press;
  final String status;
  final String date;
  final String rate;
  final String currency;
  final String gatewayImageUrl;
  final String gatewayName;
  final String username;
  final String tradeType;
  final String window;
  final Color statusColor;
  final String userImage;
  const TradeListItem({Key? key,required this.userImage,required this.statusColor,required this.window,required this.gatewayName,required this.gatewayImageUrl,required this.username,required this.tradeType,required this.press,required this.currency,required this.status,required this.rate,required this.date}) : super(key: key);

  @override
  State<TradeListItem> createState() => _TradeListItemState();
}

class _TradeListItemState extends State<TradeListItem> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.press,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                Dimensions.cornerRadius),
            border: Border.all(
                color: MyColor.borderColor, width: 1)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children:  [
                Expanded(
                  child: Row(
                    children: [
                      CircleButtonWithIcon(isAsset: false,isIcon: false,bg: MyColor.transparentColor,
                        press: (){},
                        circleSize: 20,
                        imageSize: 20,
                        padding: 0,
                        imagePath: widget.userImage,),
                      const SizedBox(width: 5,),
                      Flexible(
                        child: Text(
                          widget.username,
                          style: mulishRegular,overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      TrxTypeBtn(
                        text:widget.tradeType.tr,
                        bgColor: widget.tradeType.toLowerCase()=='buy'
                            ? MyColor.primaryColor
                            : MyColor.secondaryColor,
                      )
                    ],

                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                  widget.date,
                  overflow: TextOverflow.ellipsis,
                  style: mulishRegular.copyWith(color: MyColor.textColor),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColor.bgColor1),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                      child:
                  Row(
                    children: [
                      CircleButtonWithIcon(
                       padding: 0,
                        circleSize: Dimensions.gatewayImageSize,
                        imageSize: Dimensions.gatewayImageSize,
                        isAsset: false,
                        press: () {},
                        icon: Icons.paypal_outlined,
                        bg: Colors.transparent,
                        imagePath: widget.gatewayImageUrl,
                        isIcon: false,
                        iconColor: MyColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                       Expanded(
                         child: Text(
                          widget.gatewayName,
                          style: mulishRegular,
                           overflow: TextOverflow.ellipsis,
                      ),
                       ),
                    ],
                  )),
                   const SizedBox(width: 8,),
                   Expanded(
                     flex: 2,
                     child: Align(
                       alignment: Alignment.bottomRight,
                       child:Text(
                      "${MyStrings.rate}: ${widget.rate} \n${widget.currency}",
                      textAlign: TextAlign.end,
                      style: mulishRegular,
                  )),
                   ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  "${MyStrings.window.tr}: ${widget.window} ${MyStrings.minutes.tr}",
                  style: mulishRegular,
                ),
                StatusButton(text: widget.status, bgColor: widget.statusColor),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
