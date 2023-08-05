import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import '../../../core/utils/dimensions.dart';


class LightText extends StatelessWidget {
  const LightText({Key? key,this.isAlignCenter=false,required this.text,this.size=Dimensions.fontLarge,this.space=8,this.bottom=8}) : super(key: key);
  final String text;
  final double size;
  final double space;
  final double bottom;
  final bool isAlignCenter;

  @override
  Widget build(BuildContext context) {
    return
        Text(text.tr,style: mulishRegular.copyWith(fontSize: size,color: MyColor.bodyTextColor),textAlign: isAlignCenter?TextAlign.center:TextAlign.start,);
  }
}
