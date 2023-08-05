

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/chat_widget/chat_list_item_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/chat_widget/input_widget.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {

  final ScrollController listScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RunningTradeDetailsController>(builder: (controller)=>Column(
      children: [
        const SizedBox(height:15,),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
              color: MyColor.primaryColor800
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(child: Row(
                children: [
                   CircleButtonWithIcon(isAsset:false,isIcon:false,imagePath:'${UrlContainer.baseUrl}${controller.userImagePath}/${controller.isBuyer?controller.model.data?.tradeDetails?.seller?.image:controller.model.data?.tradeDetails?.buyer?.image}',circleSize: 30,imageSize: 27,padding: 3,bg: MyColor.colorWhite,press: (){},),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.isBuyer?controller.model.data?.tradeDetails?.seller?.username??MyStrings.seller.tr:controller.model.data?.tradeDetails?.buyer?.username??MyStrings.buyer.tr,
                          style: mulishRegular),
                    ],
                  ),
                ],
              )),


              ],
            ),
          ),
        const SizedBox(height: 10,),
        Expanded(child: Container(
          color: MyColor.transparentColor,
          child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: controller.chatList.length,
            reverse: true,
            controller: listScrollController,
            itemBuilder: (context, index) =>ChatItemWidget(
              chats: controller.chatList[controller.chatList.length-1-index],
              myUserId: controller.repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIdKey)??'-1',
              index: index,
              myImageUrl: controller.isBuyer?controller.model.data?.tradeDetails?.buyer?.image:controller.model.data?.tradeDetails?.seller?.image,
              otherImageUrl:controller.chatList[controller.chatList.length-1-index].admin!=null?'admin': !controller.isBuyer?controller.model.data?.tradeDetails?.buyer?.image:controller.model.data?.tradeDetails?.seller?.image,
            ),
          ),
        )),
        controller.model.data?.chatPermission!=null && controller.model.data!.chatPermission!='0'? const ChatInputWidget():const SizedBox()
      ],
    ));
  }


}
