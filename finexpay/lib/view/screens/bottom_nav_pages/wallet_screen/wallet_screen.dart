import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/data/controller/wallet/wallet_controller/wallet_controller.dart';
import 'package:local_coin/data/repo/wallet_repo/wallet_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/bottom_Nav/bottom_nav.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/wallet_screen/widget/wallet_list_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/wallet_screen/widget/wallet_shimmer.dart';

import '../../../../core/utils/dimensions.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {

    
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WalletRepo(apiClient: Get.find()));
    final controller = Get.put(WalletController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: SafeArea(
        child:GetBuilder<WalletController>(builder: (controller)=> Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: CustomAppBar(
          title: MyStrings.myWallet,
          isShowBackBtn: false,
          bgColor: MyColor.transparentColor,
          isShowActionBtn: true,
        ),
        body:
        controller.walletLoading?const WalletShimmer():
        controller.noInternet?NoDataOrInternetScreen(isNoInternet: true,onChanged: (value){
          if(value){
            if(value){
              controller.changeNoInternetStatus(false);
              controller.initData();
            }
          }
        },):controller.walletList.isEmpty?
        const SizedBox(child: NoDataOrInternetScreen(message2: MyStrings.emptyWalletLogMsg,)):
        Container(
            padding: const EdgeInsets.all( Dimensions.screenPadding),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: controller.walletList.length,
                itemBuilder: (context, index) {
                  return WalletListWidget(
                      depositCharge: controller.getCharge(controller.walletList[index].crypto?.dcFixed??'0', controller.walletList[index].crypto?.dcPercent??"0"),
                      wallet: controller.walletList[index],
                      imagePath: controller.imagePath
                  );
                }),

        ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
          ),
        )
      ),
    );
  }
}
