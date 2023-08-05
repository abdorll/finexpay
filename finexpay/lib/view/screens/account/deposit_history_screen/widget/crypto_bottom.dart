

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:local_coin/view/components/bottom_sheet_card/bottom_sheet_card.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/controller/deposit_controller/deposit_controller.dart';


class CustomBottomSheet{

  static void showDepositSheet(List<String>list,String header,BuildContext context,{bool fromDeposit=true}){


    if (list.isNotEmpty) {

      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
                minChildSize: 0.15,
                initialChildSize: CustomValueConverter.getBottomSheetHeight(list.length,hasHeader: true),
                expand: false,
                builder: (context, scrollController) {
                  return Container(
                    //height: MediaQuery.of(context).size.height * .65,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        const SizedBox(height: 8,),
                        Center(
                          child: Container(
                            height: 5,
                            width: 100,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColor.bgColor1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18,),
                        Text(header.tr, style: mulishSemiBold.copyWith(
                            fontSize: Dimensions.fontLarge),),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: MyColor.transparentColor,
                                    onTap: () {

                                      String value = list[index];


                                      if(fromDeposit){
                                        Get.find<DepositController>().changeCurrency(value);
                                      }else {
                                        Get.find<WithdrawHistoryController>().changeCurrency(value);
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: BottomSheetCard(
                                      child: Text(
                                         list[index].tr,
                                        style: mulishRegular,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                });
          });
    }
    else {}
  }
}
