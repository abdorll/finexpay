
import 'package:flutter/material.dart';
import '../../../../core/utils/my_color.dart';

class RadiusCardShape extends StatelessWidget {
  final double padding;
  final double margin;
  final double cardRadius;
  final Color cardBgColor;
  final Widget widget;
  final double height;
  final double width;
  final bool isCircle;
  final bool showBorder;
  const RadiusCardShape({Key? key,this.showBorder=false,this.height=0,this.width=0,this.isCircle=false,this.padding=15.0,this.margin=0,this.cardRadius=15,this.cardBgColor=MyColor.colorWhite,required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isCircle? Container(
      alignment: showBorder?Alignment.center:Alignment.bottomLeft,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        color: cardBgColor,
        border: Border.all(color: MyColor.borderColor,width: showBorder? .5:0),
      ),
      child: widget,
    ):Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          color: cardBgColor,
          shape: BoxShape.circle
      ),
      child: widget,
    );
  }
}
