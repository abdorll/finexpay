import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

import '../../../../core/utils/my_color.dart';


class TextFieldContainer2 extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isShowSuffixView;
  final bool isShowBorder;
  final bool fromRight;

  final String? prefixWidgetValue;

  const TextFieldContainer2({
    Key? key,
    required this.child,
    required this.onTap,
    this.isShowBorder=true,
    this.isShowSuffixView = false,
    this.prefixWidgetValue,
    this.fromRight=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
        decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          border:Border.all(color: isShowBorder?MyColor.bgColor1:Colors.transparent, width: 0.5),
        ),
        child: isShowSuffixView ?
        IntrinsicHeight(
          child: fromRight?Row(children:
          [Expanded(child: child),
            Container(
              height: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.textFieldRadius),bottomRight:Radius.circular(Dimensions.textFieldRadius) ),
                  color: MyColor.primaryColor),
              child: Text((prefixWidgetValue??'').tr,style: mulishBold.copyWith(color: MyColor.colorWhite),),
            ),],):Row(children:
          [
            Container(
              height: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.textFieldRadius),bottomLeft:Radius.circular(Dimensions.textFieldRadius) ),
                  color: MyColor.primaryColor),
              child: Text((prefixWidgetValue??'').tr,style: mulishBold.copyWith(color: MyColor.colorWhite),),
            ),Expanded(child: child)],),
        ):child,
      ),
    );
  }
}