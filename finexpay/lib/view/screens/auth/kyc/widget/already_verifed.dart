import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_icons.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';

class AlreadyVerifiedWidget extends StatefulWidget {
  final bool isPending;
  const AlreadyVerifiedWidget({Key? key,this.isPending=false}) : super(key: key);

  @override
  State<AlreadyVerifiedWidget> createState() => _AlreadyVerifiedWidgetState();
}

class _AlreadyVerifiedWidgetState extends State<AlreadyVerifiedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  const EdgeInsets.all(Dimensions.fontExtraLarge),
      margin: Dimensions.dialogContainerMargin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColor.colorWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.isPending?MyIcons.pendingIcon:MyIcons.verifiedIcon,height: 150,width: 150,fit: BoxFit.cover,),
          const SizedBox(height: 25,),
          Text(widget.isPending?MyStrings.kycUnderReviewMsg.tr:MyStrings.kycAlreadyVerifiedMsg.tr,style: mulishSemiBold.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontExtraLarge,)),
          const SizedBox(height: 40,)
        ],
      ),
    );
  }
}
