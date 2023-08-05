import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/deposit/DepositResponseModel.dart';

import '../../../../../../../../../core/utils/my_color.dart';
import '../../../../../../core/helper/date_converter.dart';
import '../../../../../../core/helper/string_format_helper.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../data/controller/deposit_controller/deposit_controller.dart';
import '../../../../../components/buttons/circle_button_with_icon.dart';
import '../../../../../components/row_item/custom_row.dart';
import '../../.././../../../core/utils/dimensions.dart';


class DepositHistoryListItem extends StatefulWidget {

  const DepositHistoryListItem({Key? key,required this.expandIndex,required this.listItem,required this.index,required this.imagePath}) : super(key: key);
  final DepositModel listItem;
  final int index;
  final String imagePath;
  final int expandIndex;

  @override
  State<DepositHistoryListItem> createState() => _DepositHistoryListItemState();
}



class _DepositHistoryListItemState extends State<DepositHistoryListItem> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: MyColor.borderColor,width: 1)
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleButtonWithIcon(isIcon:false,press:(){},imagePath: widget.imagePath,circleSize:30,padding:0,bg:MyColor.transparentColor,imageSize: 30,isAsset: false,),
                const SizedBox(width: 12,),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyStrings.amount.tr,style:mulishRegular.copyWith(color: MyColor.hintTextColor),),
                      const SizedBox(height: 2,),
                      Text("${widget.listItem.amount??'0.0'} ${widget.listItem.crypto?.code??''}"            ,
                          style: mulishSemiBold.copyWith(fontSize: Dimensions.fontDefault,color: MyColor.colorBlack))
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(MyStrings.trxId.tr,style: mulishRegular.copyWith(color: MyColor.hintTextColor),),
                      const SizedBox(height: 2,),
                      Text("${widget.listItem.trx}",style: robotoBold.copyWith(color: MyColor.textColor,fontSize: Dimensions.fontSmall),)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            const Divider(height: 1,color: MyColor.borderColor,),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.expandIndex==widget.index?'':MyStrings.more.tr,style: mulishRegular,),
                CircleButtonWithIcon(
                    padding: 5,
                    circleSize: 25,
                    imageSize: 20,
                    bg: MyColor.bgColor1,
                    iconSize: 20,
                    iconColor: MyColor.colorBlack,
                    isIcon: true,
                    icon: widget.expandIndex==widget.index?Icons.expand_less:Icons.expand_more,
                    press: (){
                      if(widget.expandIndex==widget.index){
                        Get.find<DepositController>().changeExpandIndex(-1);
                      }else{
                        Get.find<DepositController>().changeExpandIndex(widget.index);
                      }

                    })
              ],
            ),
            widget.expandIndex==widget.index?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                CustomRow(firstText: MyStrings.time, lastText: "${DateConverter.isoStringToLocalDateOnly(widget.listItem.createdAt??'')}, ${DateConverter.isoStringToLocalTimeOnly(widget.listItem.createdAt??'')}"),
                CustomRow(firstText: MyStrings.charge, lastText: "${widget.listItem.charge} ${widget.listItem.crypto?.code}"),
                CustomRow(firstText:MyStrings.afterCharge,lastText:  "${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(widget.listItem.finalAmo??'0',precision: 8)} ${widget.listItem.crypto?.code}"),
                CustomRow(firstText:MyStrings.payableAmount,lastText:  "${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(widget.listItem.finalAmo??'0',precision: 8)} ${widget.listItem.crypto?.code}",showDivider: false,),
              ],
            ) : const SizedBox.shrink()
          ],
        ),
      )
    );

  }


}