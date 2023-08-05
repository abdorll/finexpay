import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/buttons/status_button.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';

class CustomRow extends StatelessWidget {
  final String firstText,lastText;
  final bool isStatus,isAbout,showDivider;
  final Color statusTextColor;
  final bool hasChild;
  final Widget? child;
  const CustomRow({Key? key,this.child,this.hasChild=false,this.statusTextColor=MyColor.greenSuccessColor,required this.firstText,required this.lastText,this.isStatus=false,this.isAbout=false,this.showDivider=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasChild?Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText.tr,style: mulishRegular,overflow: TextOverflow.ellipsis,maxLines: 1,)),
            child??const SizedBox(),
          ],
        ),
        const SizedBox(height: 5,),
        showDivider? const Divider(color: MyColor.borderColor,) : const SizedBox(),
        showDivider? const SizedBox(height: 5,) : const SizedBox(),
      ],
    ): isAbout ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(firstText.tr,style: mulishRegular,),
        const SizedBox(height: 4,),
       Text(lastText.tr,style: robotoRegular.copyWith(color: isStatus?statusTextColor:MyColor.hintTextColor),),
        const SizedBox(height: 5,),
      ],
    ) :
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText.tr,style: mulishRegular,overflow: TextOverflow.ellipsis,maxLines: 1,)),
            isStatus?StatusButton(text: lastText.tr, bgColor: statusTextColor) :Flexible(child:Text(lastText.tr,maxLines:2,style:robotoRegular.copyWith(color: isStatus?MyColor.greenSuccessColor:MyColor.colorBlack),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))
          ],
        ),
        const SizedBox(height: 5,),
        showDivider? const Divider(color: MyColor.borderColor,) : const SizedBox(),
        showDivider? const SizedBox(height: 5,) : const SizedBox(),
      ],
    );
  }
}
