import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/data/controller/notifications/notification_controller.dart';
import 'package:local_coin/data/repo/notification_repo/notification_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/buttons/custom_icon.dart';
import 'package:local_coin/view/screens/notification/widget/notification_shimmer.dart';

import '../../../core/utils/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<NotificationsController>().initData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<NotificationsController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(NotificationRepo(apiClient: Get.find()));
    final controller = Get.put(NotificationsController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.initData();
      controller.clearActiveNotificationInfo();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: MyStrings.myNotifications),
      body: GetBuilder<NotificationsController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            color: MyColor.primaryColor,
            backgroundColor: MyColor.colorWhite,
            onRefresh: () async {
              controller.page = 0;
              await controller.initData();
            },
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: controller.isLoading
                    ? const NotificationShimmer()
                    : controller.notificationList.isEmpty?const NoDataOrInternetScreen(message2: MyStrings.emptyNotificationLogMsg,):ListView.builder(
                        controller: _controller,
                        itemCount: controller.notificationList.length+1,
                        itemBuilder: (context, index) {

                          if (controller
                              .notificationList.length ==
                              index) {
                            return controller.hasNext()
                                ? const Center(
                                child:
                                CircularProgressIndicator(color: MyColor.primaryColor,))
                                : const SizedBox();
                          }
                          bool isNotRead=controller.notificationList[index]
                              .readStatus ==
                              '0';
                          String remarks=controller.notificationList[index].remark??'';
                          return GestureDetector(
                              onTap: () {
                                controller.markAsReadAndGotoThePage(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 5,bottom: 5,right: 5),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: MyColor.borderColor,width: .5),
                                    color: isNotRead
                                        ? MyColor.bgColor1
                                        : MyColor.colorWhite),
                                child: ListTile(
                                  leading: SizedBox(
                                      width:35,
                                      height:35,
                                      child: CustomIcon(bg:controller.getIconColor(remarks),
                                        press: () {},
                                        isIcon: true,
                                        isSvg: true,
                                        imagePath:controller.getIcon(remarks),
                                        iconSize: 25,
                                        iconColor:Colors.white,
                                        circleSize: 34,
                                        padding: 8,)),
                                  title: Text(controller.notificationList[index].title ?? '',
                                    style: mulishRegular,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(
                                            DateConverter.isoStringToLocalFormattedDateOnly(
                                                controller.notificationList[index]
                                                        .createdAt ??
                                                    '0'),
                                            style: robotoRegular.copyWith(color: MyColor.textColor),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );})),
          ),
        ),
      ),
    );
  }
}
