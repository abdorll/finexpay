import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';

import '../../../../../core/helper/string_format_helper.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/controller/advertisement_controller/new_advertisement_controller.dart';

showMyBottomSheet(
    List<String>? list,
    String callFrom,
    BuildContext context,
    String header,
    ) {
  if (list != null && list.isNotEmpty) {

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
                              return GestureDetector(
                                onTap: () {

                                  final controller = Get.find<
                                      NewAdvertisementController>();
                                  if (callFrom == '1') {
                                    controller.changeTrxType(index);
                                  } else if (callFrom == '2') {
                                    controller.changeCrypto(index);
                                  } else if (callFrom == '3') {
                                    controller.changePaymentMethod(index);
                                  } else if (callFrom == '4') {
                                    controller.changeFiatCurrency(index);
                                  } else if (callFrom == '5') {
                                    controller.changePaymentWindow(index);
                                  } else if (callFrom == '6') {
                                    controller.changePriceType(index);
                                  }
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: MyColor.bgColor1,
                                    border: Border.all(
                                        color: MyColor.borderColor),
                                  ),


                                  child: Text(
                                    '  ${callFrom == '10'
                                        ? CustomValueConverter
                                        .replaceUnderscoreWithSpace(
                                        list[index].capitalizeFirst ?? '').tr
                                        : list[index].tr}',
                                    style: mulishRegular,
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
  } else {}
}

