

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/data/controller/withdraw/withdraw_history_controller.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';


class CustomBottomSheet{

  static void showWithdrawSheet(List<String>list,String header,BuildContext context){


    if (list.isNotEmpty) {

      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
                minChildSize: 0.15,
                initialChildSize: list.length>2?0.6:0.3,
                expand: false,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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


                                        Get.find<WithdrawHistoryController>().changeCurrency(value);


                                      Navigator.pop(context);


                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: MyColor.bgColor1
                                      ),


                                      child: Text(
                                         list[index],
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
