

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/action_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/chat_widget/chat_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/shimmer/action_shimmer.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/repo/trade/trade_details_repo/trade_details_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/CustomNoDataFoundClass.dart';
import '../../../../components/app_bar/custom_appbar.dart';

class TradeDetailsScreen extends StatefulWidget {
  const TradeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TradeDetailsScreen> createState() => _TradeDetailsScreenState();
}

class _TradeDetailsScreenState extends State<TradeDetailsScreen> {


  late String trxId;

  @override
  void initState() {

    trxId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TradeDetailsRepo(apiClient: Get.find()));
    final controller=Get.put(RunningTradeDetailsController(repo:  Get.find()));
    controller.tradeNumber=trxId;
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
      if (Platform.isAndroid) {
        controller.platform = TargetPlatform.android;
      } else {
        controller.platform = TargetPlatform.iOS;
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const    CustomAppBar(title: MyStrings.tradeDetails,isShowBackBtn: true,isShowActionBtn: true,),
        body:GetBuilder<RunningTradeDetailsController>(builder: (controller)=>
            Container(
              padding: const EdgeInsets.all(Dimensions.screenPadding),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:controller.noInternet?NoDataOrInternetScreen(isNoInternet: true,imageHeight: .7,paddingTop: 5,onChanged: (b){
                if(b){
                  controller.changeNoInternetStatus(false);
                  controller.initData();
                }
              },):
              controller.isLoading?const ActionShimmer():Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if(!controller.isAction){
                              controller.changeTabBarMenu();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(Dimensions.cornerRadius),
                                  topEnd: Radius.zero,
                                  bottomStart: Radius.circular(Dimensions.cornerRadius),
                                  bottomEnd: Radius.zero
                              ),
                              color: controller.isAction?MyColor.primaryColor:MyColor.bgColor1,
                            ),
                            child:  Text(MyStrings.action.tr,style: mulishSemiBold.copyWith(color: controller.isAction?MyColor.colorWhite:MyColor.colorBlack),),
                          ),
                        ),
                      ),
                      Expanded(child:  InkWell(
                        onTap: (){
                          if(controller.isAction){
                            controller.changeTabBarMenu();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:const BorderRadiusDirectional.only(
                                topStart: Radius.zero,
                                topEnd:  Radius.circular(Dimensions.cornerRadius),
                                bottomStart: Radius.zero,
                                bottomEnd: Radius.circular(Dimensions.cornerRadius)
                            ),
                            color: !controller.isAction?MyColor.primaryColor:MyColor.bgColor1,
                          ),
                          child:  Text(MyStrings.chat.tr,style: mulishSemiBold.copyWith(color: !controller.isAction?MyColor.colorWhite:MyColor.colorBlack),),
                        ),


                      ),),
                    ],
                  ),
                  controller.isAction?
                  const Expanded(child:  ActionWidget()):
                  const Expanded(child:  ChatWidget())
                ],
              ),
            )
        ),),
    );
  }
}