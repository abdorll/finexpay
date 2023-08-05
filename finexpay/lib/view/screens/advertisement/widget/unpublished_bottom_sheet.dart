import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/advertisement_controller/advertisement_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';

showUnpublishedSheet(
    BuildContext context,
   List<String>list,
    ) {

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<AdvertisementController>(builder: (controller)=> DraggableScrollableSheet(
              minChildSize: 0.20,
              initialChildSize:list.length>5?0.75:list.length>2?0.5:list.length>1?0.25:0.20,
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
                  child:Column(
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
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MyStrings.unpublishedReason.tr,style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge),),
                          CircleButtonWithIcon(
                            bg: MyColor.bgColor1,
                            press: (){
                              Get.back();
                            },iconColor: MyColor.colorBlack,circleSize: 26,iconSize: 20,padding: 6,isIcon: true,isSvg: false,)
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Expanded(child: ListView.builder(
                        itemCount: list.length,
                          itemBuilder: (context, index) {
                          return  Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: MyColor.transparentColor,
                            ),
                            child: Text(
                              '${index+1}.${list[index]}'.tr,
                              style: mulishRegular.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.redCancelTextColor),
                            ),
                          );
                          }
                      ))
                    ],
                  ),
                );
              }));
        });
  
}