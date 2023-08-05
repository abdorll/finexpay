import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/trade_widget/trade_header_widget.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';

class TradeWidget extends StatelessWidget {

  final String headerText;
  final String? bodyText;
  final Widget?child;
  final bool showChild;
  final bool isUserInfo;
  final Color bgColor;
  final bool showBorder;

  const TradeWidget({Key? key,this.showBorder=true,this.bgColor=Colors.transparent,this.isUserInfo=false,required this.headerText,this.bodyText,this.child,this.showChild=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TradeHeaderWidget(text:  headerText,isShowIcon: isUserInfo,bgColor: bgColor,mainBg: bgColor,),
          showBorder?Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColor.transparentColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: MyColor.borderColor)
               ),
            child:showChild?child: Text((bodyText??'').tr,
              style: robotoLight.copyWith(color: MyColor.bodyTextColor),
            ),
          ):showChild?child!:Text((bodyText??'').tr,
            style: robotoLight.copyWith(color: MyColor.bodyTextColor),
          ),
        ],
      ),
    );
  }
}
