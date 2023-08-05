import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';

class LatestResultListItem extends StatelessWidget {

  final String text;
  final String quantity;
  final String icon;
  final Color bgColor;
  final Color textColor;

  const LatestResultListItem({Key? key,
  required this.text,
  required this.quantity,
  required this.icon,
  this.textColor = MyColor.colorWhite,
  required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [
            bgColor,
            bgColor.withOpacity(.95),
            bgColor.withOpacity(.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleButtonWithIcon(
            press: () {},
            bg: bgColor,
            isIcon: true,
            isAsset: true,
            circleSize: 38,
            imageSize: 35,
            padding: 3,
            borderColor: Colors.transparent,
            isSvg: true,
            iconColor: MyColor.colorWhite,
            imagePath: icon,
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  quantity.padLeft(2,'0'),
                  style: mulishRegular.copyWith(
                      fontSize: Dimensions.fontExtraLarge,color: textColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text.tr,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontDefault,color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
