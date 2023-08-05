import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:local_coin/data/model/withdraw/WithdrawHistoryResponseModel.dart';

import '../../../../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../components/buttons/circle_button_with_icon.dart';
import '../../../../../components/row_item/custom_row.dart';
import '../../.././../../../core/utils/dimensions.dart';


class WithdrawHistoryListItem extends StatefulWidget {


  const WithdrawHistoryListItem({Key? key,required this.status,required this.statusBG,required this.expandIndex,required this.listItem,required this.index,required this.imagePath}) : super(key: key);
  final WithdrawModel listItem;
  final int index;
  final String imagePath;
  final int expandIndex;
  final String status;
  final Color statusBG;

  @override
  State<WithdrawHistoryListItem> createState() => _WithdrawHistoryListItemState();
}



class _WithdrawHistoryListItemState extends State<WithdrawHistoryListItem> {
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
                      Text(MyStrings.amount,style:mulishRegular.copyWith(color: MyColor.hintTextColor),),
                      const SizedBox(height: 2,),
                      Text("${widget.listItem.amount??'0.0'} ${widget.listItem.crypto?.code??''}"            ,
                          style: mulishSemiBold.copyWith(fontSize: Dimensions.fontDefault,color: MyColor.colorBlack)),
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(MyStrings.trxId,style: mulishRegular.copyWith(color: MyColor.hintTextColor),),
                      const SizedBox(height: 2,),
                      Text(widget.listItem.trx??'',style: mulishRegular.copyWith(fontSize: Dimensions.fontSmall),)
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
                Text(widget.expandIndex==widget.index?'':MyStrings.more,style: mulishRegular,),
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
                        Get.find<WithdrawHistoryController>().changeExpandIndex(-1);
                      }else{
                        Get.find<WithdrawHistoryController>().changeExpandIndex(widget.index);
                      }

                    })
              ],
            ),
            widget.expandIndex==widget.index?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                CustomRow(firstText: MyStrings.charge, lastText: "${widget.listItem.charge} ${widget.listItem.crypto?.code}"),
                CustomRow(firstText: MyStrings.afterCharge, lastText: "${widget.listItem.payable} ${widget.listItem.crypto?.code}",),
                CustomRow(firstText: MyStrings.walletAddress, lastText: "${widget.listItem.walletAddress}",showDivider: widget.listItem.status=='3'?true:false,),
                widget.listItem.status=='3'?CustomRow(firstText: MyStrings.about, lastText: "${widget.listItem.adminFeedback??MyStrings.noFeedbackFound}",isAbout: true,):const SizedBox(),
              ],
            ) : const SizedBox.shrink()
          ],
        ),
      )
    );

  }



}