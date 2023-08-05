import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/my_color.dart';

class MyShimmerEffectUI extends StatelessWidget {

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const MyShimmerEffectUI.rectangular({
    Key?key,
    this.width = double.infinity,
    required this.height
  }): shapeBorder = const RoundedRectangleBorder(),super(key: key);

  const MyShimmerEffectUI.circular({
    Key?key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder()
  }):super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor:MyColor.shimmerBaseColor ,
    highlightColor: MyColor.shimmerSplashColor,
    period: const Duration(seconds: 3),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: MyColor.hintTextColor,
        shape: shapeBorder,
      ),
    ),
  );
}