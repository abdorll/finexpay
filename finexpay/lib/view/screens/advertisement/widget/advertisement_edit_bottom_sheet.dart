import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/data/controller/advertisement_controller/advertisement_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_icons.dart';
import '../../../../core/utils/styles.dart';
import '../../bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/show_divider.dart';

showEditAdvertisementBottomSheet(
    BuildContext context,
    bool isShowStatusBtn,
    int id,
{bool status=false}
    ) {


  Get.find<AdvertisementController>().activeStatus=status;

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<AdvertisementController>(builder: (controller)=>  SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
                    //height: MediaQuery.of(context).size.height * .65,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10,bottom: 5),
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
                        const SizedBox(height: 30,),
                       InkWell(
                         onTap: (){
                           Get.offAndToNamed(RouteHelper.editAdvertisementScreen,arguments: id);
                         },
                         child: Row(
                           children: [
                             CircleButtonWithIcon(
                               press: () {},
                               isIcon: true,
                               isSvg: true,
                               imagePath:MyIcons.editIcon,
                               iconColor: MyColor.primaryColor,
                               bg: MyColor.transparentColor,
                               borderColor: MyColor.transparentColor,
                               iconSize: 20,
                               circleSize: 20,
                               padding: 0,
                             ),
                             const SizedBox(width: 12,),
                             Text(MyStrings.editYourAdvertisement.tr,style: mulishRegular,)
                           ],
                         ),
                       ),
                        const CustomDivider(
                          height: 15,
                          bottom: 15,
                        ),
                        InkWell(
                          splashColor: MyColor.bgColor1,
                          onTap: (){
                            Get.back();
                            Get.toNamed(RouteHelper.advertisementReviewScreen,arguments: id);
                          },
                          child: Row(
                            children: [
                              CircleButtonWithIcon(
                                press: () {},
                                isIcon: true,
                                isSvg: true,
                                imagePath: MyIcons.ratingIcon,
                                bg: MyColor.transparentColor,
                                borderColor: MyColor.transparentColor,
                                iconSize: 20,
                                circleSize: 20,
                                padding: 0,
                                iconColor: MyColor.primaryColor,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Reviews',
                                style: mulishRegular,
                              ),
                            ],
                          ),
                        ),
                        CustomDivider(
                          height: 15,
                          bottom: controller.isStatusUpdating ? 15 : 5,
                        ),
                          Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               CircleButtonWithIcon(
                                 press: () {},
                                 isIcon: true,
                                 isSvg: true,
                                 imagePath: status
                                     ? MyIcons.visibleIcon
                                     : MyIcons.inVisibleIcon,
                                 iconColor: MyColor.primaryColor,
                                 bg: MyColor.transparentColor,
                                 borderColor: MyColor.transparentColor,
                                 iconSize: 20,
                                 circleSize: 20,
                                 padding: 0,
                               ),
                               const SizedBox(
                                 width: 12,
                               ),
                               Text(
                                 status ?  MyStrings.enabled.tr:MyStrings.disabled ,
                                 style: mulishRegular,
                               )
                             ],
                           ),
                           const SizedBox(
                             width: 12,
                           ),
                           controller.isStatusUpdating?const Center(child: SizedBox(height:25,width:25,child: CircularProgressIndicator(color: MyColor.primaryColor,)),):Transform.scale(
                               scale: 1.1,
                               child: Switch(
                                 onChanged: (value){
                                   controller.changeActiveStatus(value,id);
                                 },
                                 value: controller.activeStatus,
                                 activeColor: MyColor.primaryColor,
                                 activeTrackColor: MyColor.secondaryColor,
                                 inactiveThumbColor: MyColor.bgColor1,
                                 inactiveTrackColor: MyColor.colorGrey,
                               )
                           ),
                         ],
                       ),
                       const SizedBox(
                         height: 15,
                       ),

                      ],
                    ),
                  ),
          ),
              );
        });
  
}