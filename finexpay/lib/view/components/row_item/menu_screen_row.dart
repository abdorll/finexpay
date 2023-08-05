import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:local_coin/core/utils/my_color.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';
import '../custom_sized_box.dart';
import '../small_text.dart';


class MenuRow extends StatelessWidget {
  const MenuRow({Key? key,this.isLoading = false,required this.press,required this.iconLocation,required this.text,this.showDivider=true}) : super(key: key);
  final String iconLocation;
  final String text;
  final bool showDivider;
  final Callback press;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          const CustomSizedBox(height: 5,),
          isLoading?const Center(child: SizedBox(
              height:20,
              width:20,
              child: CircularProgressIndicator(color: MyColor.primaryColor,))):Row(
            children: [
              SvgPicture.asset(iconLocation,height: 18,width: 18,fit: BoxFit.cover,color: MyColor.colorGrey4,),
              const CustomSizedBox(width: 15,height: 0,),
              SmallText(text: text.tr,textStyle: mulishSemiBold.copyWith(fontSize: Dimensions.fontDefault),)
            ],
          ),
          const CustomSizedBox(height: 5,),
          showDivider? const Divider(color: MyColor.borderColor,): const SizedBox()
        ],
      ),
    );
  }
}