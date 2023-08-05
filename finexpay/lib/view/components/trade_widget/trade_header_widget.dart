
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/buttons/category_button.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';

   class TradeHeaderWidget extends StatelessWidget {
     final String text;
     final bool isRow;
     final bool isShowIcon;
     final String text2;
     final Color bgColor;
     final Color mainBg;
     const TradeHeaderWidget({Key? key,this.mainBg=MyColor.bgColor1,this.isShowIcon=false,required this.text,this.isRow=false,this.text2='',this.bgColor=MyColor.primaryColor500}) : super(key: key);

     @override
     Widget build(BuildContext context) {
       return  Container(
         padding: const EdgeInsets.all(10),
         width: MediaQuery.of(context).size.width,
         decoration:  BoxDecoration(
           borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.cornerRadius),topRight:  Radius.circular(Dimensions.cornerRadius)),
           color:mainBg,
         ),
         child:isShowIcon?Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(text.tr,style: robotoBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
             CircleButtonWithIcon(press: (){},isIcon: true,icon: Icons.arrow_forward,iconColor: MyColor.primaryColor,bg: MyColor.colorWhite,padding: 5,circleSize: 25,iconSize: 20,isSvg: false,)
           ],
         ) :isRow?Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(text.tr,style: robotoBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
             CategoryButton(text: text2, press: (){},horizontalPadding: 10,verticalPadding: 3,color: bgColor,textColor: MyColor.colorWhite,)
           ],
         ):Text(text.tr,style: robotoBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
       );
     }
   }

