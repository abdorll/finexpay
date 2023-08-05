import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/styles.dart';

import '../../../../../../../core/utils/my_color.dart';

class TradeInfoColumn extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;
  const TradeInfoColumn({Key? key,this.alignmentEnd=false,required this.header,required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text(header.tr,style: robotoLight.copyWith(color: MyColor.bodyTextColor),overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 5,),
        Text(body.tr,style: mulishRegular,overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
