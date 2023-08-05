

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/data/controller/filter_controller/filter_controller.dart';
import 'package:local_coin/view/components/bottom_sheet_card/bottom_sheet_card.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';

class FilterBottomSheet{

  static void showModal(List<String>list,String header,BuildContext context ,int callFrom){

    if(list.isNotEmpty){
      showModalBottomSheet(isScrollControlled:true,backgroundColor:Colors.transparent,context: context, builder: (BuildContext context){
        return DraggableScrollableSheet(
            minChildSize: 0.15,
            initialChildSize: CustomValueConverter.getBottomSheetHeight(list.length,hasHeader: true),
            expand: false,
            builder: (context, scrollController) {
              return Container(
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
                    Flexible(
                      child: ListView.builder(itemCount:list.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){

                                String value=list[index];
                                final controller= Get.find<FilterController>();

                                if(callFrom==0){
                                  controller.changeTrxType(value);
                                }else if(callFrom == 1){
                                  controller.changeCurrency(value);
                                } else if(callFrom == 2){
                                  controller.changePaymentMethod(value);
                                } else if(callFrom == 3){
                                  controller.changeFiatCurrency(value);
                                } else if(callFrom == 4){
                                  controller.changeOfferLocation(value);
                                }

                                Navigator.pop(context,value);
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                              },
                              child: BottomSheetCard(
                                child: Text(list[index].tr,style: mulishSemiBold,),
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


}}
