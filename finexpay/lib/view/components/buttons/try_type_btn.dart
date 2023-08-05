import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';

class TrxTypeBtn extends StatelessWidget {
  final String text;
  final Color bgColor;
  final bool isShowBg;
  final double minWidth;
  final double minHeight;
  const TrxTypeBtn({Key? key,this.minWidth=40,this.minHeight=10,this.isShowBg=true,required this.text,required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
            minHeight: minHeight
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color:bgColor),
        child: Text(
         text.tr,
          style: mulishRegular.copyWith(
              fontSize: Dimensions.fontSmall,
              color: MyColor.colorWhite),
        ),
      ),
    );
  }
}
