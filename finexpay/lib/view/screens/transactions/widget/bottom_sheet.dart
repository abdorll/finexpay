

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/bottom_sheet_card/bottom_sheet_card.dart';

import '../../../../core/helper/string_format_helper.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/transaction_controller/transaction_controller.dart';

showTrxBottomSheet(

    List<String>? list,
    int callFrom,
    {required BuildContext context}
    ) {
  if (list != null && list.isNotEmpty) {

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              minChildSize: 0.15,
              initialChildSize: CustomValueConverter.getBottomSheetHeight(list.length),
              expand: true,
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
                      const SizedBox(
                        height: 15,
                      ),
                      Flexible(
                        child: ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: const Color(0x8034b0fc),
                                  onTap: () {
                                    String selectedValue = list[index];
                                    final controller = Get.find<
                                        TransactionController>();
                                    if (callFrom == 1) {
                                      controller.changeSelectedTrxType(
                                          selectedValue);
                                    } else if (callFrom == 2) {
                                      controller.changeSelectedRemark(
                                          selectedValue);
                                    } else if (callFrom == 3) {
                                      controller.changeSelectedCrypto(
                                          selectedValue);
                                    }
                                    Navigator.pop(context);

                                    FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  child:BottomSheetCard(
                                    child: Text(
                                      '  ${callFrom == 2
                                          ? CustomValueConverter
                                          .replaceUnderscoreWithSpace(
                                          list[index].capitalizeFirst ?? '')
                                          : list[index]}'.tr,
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
  } else {}
}