import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';

class StatusButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final bool isShowBg;
  final double minWidth;
  final double minHeight;
  const StatusButton({Key? key,this.minWidth=45,this.minHeight=10,this.isShowBg=true,required this.text,required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: mulishRegular.copyWith(
          fontSize: Dimensions.fontDefault,
          color: bgColor),
    );
  }
}
