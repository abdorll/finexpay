import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String? iconUrl;
  final String text;
  final double iconSize;
  final Color iconColor;
  final double textSize;
  const IconWithText({Key? key,this.iconUrl,this.iconColor=MyColor.colorBlack,this.textSize=Dimensions.fontSmall,this.iconSize=13,this.icon=Icons.clear,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        iconUrl==null?Icon(icon,size: iconSize,color: iconColor,):SvgPicture.asset(iconUrl!,color: iconColor,height: iconSize,width: iconSize,),
        const SizedBox(width: 10,),
        Text(text.tr,style: mulishRegular.copyWith(fontSize: Dimensions.fontSmall),)
      ],
    );
  }
}
