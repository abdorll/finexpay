import 'package:flutter/material.dart';

import '../../../../core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color color, textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  const RoundedLoadingBtn({
    Key? key,
    this.width=1,
    this.cornerRadius=8,
    this.horizontalPadding=35,
    this.verticalPadding=18,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: MyColor.transparentColor,
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding-3),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
      child:SizedBox(width:20,height:20,child: CircularProgressIndicator(color: textColor,strokeWidth: 2,)),
    );
  }
}