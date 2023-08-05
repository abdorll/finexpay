

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';

class FilterRowWidget extends StatefulWidget {

  final String text;
  final bool fromTrx;
  final Color iconColor;
  final VoidCallback press;
  final bool isFilterBtn;
  final Color bgColor;

  const FilterRowWidget({Key? key,this.bgColor=MyColor.bgColor1,this.isFilterBtn=false,this.iconColor=MyColor.primaryColor,required this.text,required this.press,this.fromTrx=false}) : super(key: key);

  @override
  State<FilterRowWidget> createState() => _FilterRowWidgetState();
}

class _FilterRowWidgetState extends State<FilterRowWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.press,
      child: SizedBox(
        //width: 120,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: widget.isFilterBtn?MyColor.primaryColor:widget.bgColor,
              border: Border.all(color: MyColor.borderColor,width: widget.isFilterBtn?0: 0.5)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
             widget.fromTrx?Text(widget.text.tr,style: robotoRegular.copyWith(overflow: TextOverflow.ellipsis,color: widget.isFilterBtn?MyColor.colorWhite:MyColor.colorBlack)): Expanded(child: Text(widget.text.tr,style: robotoRegular.copyWith(color:MyColor.textColor0,overflow: TextOverflow.ellipsis),)),
              const SizedBox(width: 20,),
               Icon(Icons.expand_more,color: widget.iconColor,size: 17,)
            ],
          ),
        ),
      ),
    );
  }
}
