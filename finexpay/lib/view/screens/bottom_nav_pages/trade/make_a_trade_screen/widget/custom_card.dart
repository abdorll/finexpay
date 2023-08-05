import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../components/buttons/circle_button_with_icon.dart';

class CustomCard extends StatelessWidget {
  final String headerText;
  final Widget? child;
  final bool showMorBtn;
  final Callback? press;
  const CustomCard({Key? key,this.press,required this.headerText,required this.child,this.showMorBtn=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Card(
          margin: const EdgeInsets.all(0),
          color: MyColor.colorWhite,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText.isEmpty?const SizedBox():Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(headerText.tr,style: robotoBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
                    showMorBtn?CircleButtonWithIcon(press:press??(){

                    },
                      isIcon: true,icon: Icons.arrow_forward,iconColor: MyColor.primaryColor,bg: MyColor.colorWhite,padding: 5,circleSize: 25,iconSize: 20,isSvg: false,):const SizedBox()

                  ],
                ),
                const SizedBox(height: 10,),
                child!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
