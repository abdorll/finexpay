import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../../../core/utils/my_color.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Callback press;
  final double padding;
  final String imagePath;
  final Color bg;
  final bool isIcon;
  final bool isAsset;
  final double circleSize;
  final double imageSize;
  final Color iconColor;
  final Color borderColor;
  final double iconSize;
  final bool isSvg;
  final bool isShowBorder;

  const CustomIcon(
      {Key? key,
      this.imagePath = '',
        this.isAsset=false,
        this.circleSize=30,
        this.imageSize=20,
        this.isSvg=false,
        this.isShowBorder=false,
      this.isIcon = true,
      this.bg = Colors.transparent,
      this.padding = 5,
      required this.press,
        this.iconColor=MyColor.colorWhite,
        this.iconSize=20,
        this.borderColor=MyColor.borderColor,
      this.icon = Icons.clear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(padding),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bg,border: Border.all(color: borderColor,width: isShowBorder?1.5:0)),
              child: isSvg?SvgPicture.asset(imagePath,height: iconSize,width: iconSize,color: iconColor,):Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          );

  }
}
