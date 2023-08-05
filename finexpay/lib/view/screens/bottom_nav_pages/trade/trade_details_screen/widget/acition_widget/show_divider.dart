import 'package:flutter/material.dart';

import '../../../../../../../core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double bottom;
  const CustomDivider({Key? key,this.height=12,this.bottom=12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
        ),
        const Divider(color: MyColor.borderColor,height: 1.5,),
        SizedBox(
          height: bottom,
        ),
      ],
    );
  }
}
