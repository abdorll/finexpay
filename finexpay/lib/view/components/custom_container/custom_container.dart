import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';


class CustomContainer extends StatelessWidget {
  final Color bg;
  final Widget child;
  final double paddingH;
  final double paddingV;
  const CustomContainer({Key? key,this.bg=MyColor.bgColor1,required this.child,this.paddingH=5,this.paddingV=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:
      const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(
              6),
          color: MyColor.testColor),
      child: child,
    );
  }
}
