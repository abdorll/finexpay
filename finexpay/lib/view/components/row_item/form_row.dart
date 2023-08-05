import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';

import '../../../core/utils/styles.dart';


class FormRow extends StatelessWidget {
  const FormRow({Key? key,required this.label,required this.isRequired}) : super(key: key);
  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label.tr,style: mulishBold.copyWith(color: MyColor.colorBlack),),
        Text(isRequired?' *':'',style: mulishBold.copyWith(color: MyColor.redCancelTextColor),)
      ],
    );
  }
}
