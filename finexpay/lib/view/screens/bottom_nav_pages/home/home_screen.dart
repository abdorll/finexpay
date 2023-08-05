import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_result_widget/latest_result_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_trade_offer_widget/latest_trade_offer_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/refer_link_widget/referlink_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/user_info_widget/user_info_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/wallet_widget/wallet_widget.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../data/controller/home/home_controller.dart';
import '../../../../data/repo/home_repo/home_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/bottom_Nav/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller=Get.put(HomeController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });

  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return WillPopWidget(
        nextRoute: '',
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bgColor1,
            body:controller.noInternet?NoDataOrInternetScreen(isNoInternet: true,imageHeight: .7,paddingTop: 5,onChanged: (b){
              if(b){
                controller.changeNoInternetStatus(false);
                controller.initData();
              }
            },): SizedBox(
              height: MediaQuery.of(context).size
              .height,
              width: MediaQuery.of(context).size.width,
              child: RefreshIndicator(color: MyColor.primaryColor,
                backgroundColor: MyColor.colorWhite,
                onRefresh: () async {
                  await controller.initData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child:  Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            child: Stack(
                              clipBehavior:Clip.none,
                              children: [
                                const UserInfoWidget(),
                                spaceBetweenRow(),
                                const Positioned(
                                  bottom: -30,
                                  child: WalletWidget()),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.screenPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30,),
                                    const LatestResultWidget(),
                                    spaceBetweenRow(),
                                    const SizedBox(width:double.infinity ,child: LatestTradeOfferWidget()),
                                    spaceBetweenRow(),
                                    const ReferLinkWidget()
                                  ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const CustomBottomNav(currentIndex:0),
          ),
        ),
      );
    });
  }



  Widget spaceBetweenRow(){
    return const SizedBox(height: 13,);
  }


}
