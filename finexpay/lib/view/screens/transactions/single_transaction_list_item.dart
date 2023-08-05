import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/transaction_response_model/TransactionResponseModel.dart';
import 'package:local_coin/view/components/row_item/custom_row.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/transaction_controller/single_transaction_controller.dart';
import '../../components/buttons/circle_button_with_icon.dart';


class SingleTransactionListItem extends StatelessWidget {
  final String imagePath;
  final Data trxModel;
  final int index;
  final int expandedIndex;
  final Callback press;
  const SingleTransactionListItem({Key? key,required this.press,required this.imagePath,required this.trxModel,required this.index,this.expandedIndex=-1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.find<SingleTransactionController>();
    return Container(
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
              CircleButtonWithIcon(isIcon:false,press:(){},imagePath: imagePath,circleSize:30,padding:0,bg:MyColor.transparentColor,imageSize: 30,isAsset: false,),
              const SizedBox(width: 12,),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.amount.tr,style:mulishRegular.copyWith(color: MyColor.hintTextColor),),
                    const SizedBox(height: 2,),
                    Text("${trxModel.amount} ${trxModel.crypto?.code}",
                        style: robotoBold.copyWith(fontSize: Dimensions.fontDefault,color: MyColor.colorBlack)),
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
                    Text("${trxModel.trx}",style: robotoBold.copyWith(color: MyColor.textColor,fontSize: Dimensions.fontSmall),)
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
               Text(index==expandedIndex?'':MyStrings.more.tr,style: mulishRegular,),
              CircleButtonWithIcon(
                  padding: 5,
                  circleSize: 25,
                  imageSize: 20,
                  bg: MyColor.bgColor1,
                  iconSize: 20,
                  iconColor: MyColor.colorBlack,
                  isIcon: true,
                  icon: expandedIndex==index?Icons.expand_more:Icons.expand_less,
                  press:(){
                   controller.changeListExpandedIndex(index);
                  }
              )
            ],
          ),
          expandedIndex==index?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10,),
              CustomRow(firstText: MyStrings.time, lastText: '${DateConverter.isoStringToLocalDateOnly(trxModel.createdAt??'')}, ${DateConverter.isoStringToLocalTimeOnly(trxModel.createdAt??'')}'),
              CustomRow(firstText: MyStrings.charge, lastText: '${trxModel.charge} ${trxModel.crypto?.code}'),
              CustomRow(firstText: MyStrings.postBalance, lastText: '${trxModel.postBalance} ${trxModel.crypto?.code}'),
              CustomRow(firstText: MyStrings.details, lastText: '${trxModel.details}',isAbout: true,),

            ],
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }

}
