import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class LabelText extends StatelessWidget {
  
  const LabelText({Key? key,
    this.press,
    this.showTooltip=false,
    this.style=mulishSemiBold,
    required this.text,
    this.size=Dimensions.fontDefault,
    this.top=8,
    this.isRequired = false,
    this.bottom=8}) : super(key: key);
  
  final String text;
  final double size;
  final double top;
  final double bottom;
  final TextStyle style;
  final bool showTooltip;
  final VoidCallback? press;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return showTooltip?Column(
      children: [
        SizedBox(height: top,),
        Row(
          children: [
            Text(text.tr,style: style.copyWith(fontSize: size,color:MyColor.textColor),),
            const SizedBox(width: 5,),
            GestureDetector(onTap: press,
                child: const Icon(Icons.info_outline,color: MyColor.primaryColor,size: 15,)
            ,)
          ],
        ),
        SizedBox(height: bottom,),
      ],
    ):isRequired?Column(
      children: [
        SizedBox(height: top,),
        Row(
          children: [
            Text(text.tr,style: style.copyWith(fontSize: size,color:MyColor.textColor),),
            const SizedBox(width: 3,),
            Text('*',style: mulishSemiBold.copyWith(color: MyColor.red),)
          ],
        ),
        SizedBox(height: bottom,),
      ],
    ):
    Column(
      children: [
        SizedBox(height: top,),
        Text(text.tr,style: style.copyWith(fontSize: size,color:MyColor.textColor),),
        SizedBox(height: bottom,),
      ],
    );
  }
}
