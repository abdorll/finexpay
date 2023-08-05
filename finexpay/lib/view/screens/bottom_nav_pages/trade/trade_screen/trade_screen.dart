import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/completed_trade/completed_trade_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/running_trade/running_trade_widget.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/controller/trade/trade_controller/trade_controller.dart';
import '../../../../../data/repo/trade/trade_repo/trade_repo.dart';
import '../../../../components/app_bar/custom_appbar.dart';
import '../../../../components/bottom_Nav/bottom_nav.dart';



class TradeScreen extends StatefulWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {


  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TradeRepo(apiClient: Get.find()));
   final controller = Get.put(TradeController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.checkAndLoadData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bgColor,
            appBar: CustomAppBar(
              title: MyStrings.trades,
              isShowBackBtn: false,
              bgColor: MyColor.transparentColor,
            ),
            body: GetBuilder<TradeController>(builder: (controller)=>Container(
                padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.screenPadding),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              if(!controller.isRunningSelected){
                                controller.changeTabMenu();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.isRunningSelected?MyColor.primaryColor:MyColor.bgColor1,
                                borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(Dimensions.cornerRadius),
                                topEnd: Radius.zero,
                                bottomStart: Radius.circular(Dimensions.cornerRadius),
                                bottomEnd: Radius.zero
                                )),
                              child:  Text(MyStrings.runningTrade.tr,style: mulishSemiBold.copyWith(color: controller.isRunningSelected?MyColor.colorWhite:MyColor.colorBlack),),
                            ),
                          ),
                        ),
                        Expanded(child:  InkWell(
                          onTap: (){
                            if(controller.isRunningSelected){
                              controller.changeTabMenu();
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
                              color: !controller.isRunningSelected?MyColor.primaryColor:MyColor.bgColor1,
                            ),
                            child:  Text(MyStrings.completed.tr,style: mulishSemiBold.copyWith(color: !controller.isRunningSelected?MyColor.colorWhite:MyColor.colorBlack),),
                          ),


                        ),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    controller.isRunningSelected?
                    const RunningTradeWidget():
                    const CompleteTradeWidget()
                  ],
                ))),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
          )),
    );
  }
}
