import 'package:flutter/material.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/styles.dart';

class CancelCard extends StatefulWidget {
  final String? text;
  const CancelCard({Key? key,required this.text}) : super(key: key);

  @override
  State<CancelCard> createState() => _CancelCardState();
}

class _CancelCardState extends State<CancelCard> {
  @override
  Widget build(BuildContext context) {
    return widget.text !=null && widget.text!.isNotEmpty?
    Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.redCancelTextColor.withOpacity(0.1),
          border: Border.all(color: MyColor.redCancelTextColor,width: .5)
      ),
      child: Text(widget.text??'',style: mulishRegular.copyWith(color: MyColor.redCancelTextColor),),
    ):const SizedBox();
  }
}
