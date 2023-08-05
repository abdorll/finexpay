import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/data/controller/menu/my_menu_controller.dart';
import 'package:local_coin/data/repo/menu_repo/menu_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/main.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/menu_screen/widget/language_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/my_color.dart';
import '../../../components/card_bg.dart';
import '../../../components/custom_sized_box.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/bottom_Nav/bottom_nav.dart';
import '../../../components/row_item/menu_screen_row.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    Get.put(MyMenuController(repo: Get.find()));

    super.initState();
    //LockScreenManager.startTimer(context);
  }

  @override
  void dispose() {
    //LockScreenManager.startTimer(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: MyStrings.userMenu,isShowBackBtn: false,isShowActionBtn: false,bgColor: MyColor.colorWhite,),
        body:  GetBuilder<MyMenuController>(builder: (controller)=>Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: MyColor.bgColor1
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSizedBox(),
                SizedBox(
                  width: double.infinity,
                  child: RadiusCardShape(cardRadius: 12,cardBgColor:MyColor.bgColor,widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.profileScreen);
                      },iconLocation:MyIcons.profileNewIcon, text: MyStrings.profile),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.changePasswordScreen);
                      },iconLocation:MyIcons.lockIcon, text:MyStrings.changePassword),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.kycScreen);
                      },iconLocation:MyIcons.kycNewIcon, text:MyStrings.kycVerification),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.notificationScreen);
                      },iconLocation:MyIcons.menuNotificationIcon, text:MyStrings.notification,showDivider: false),
                    ],
                  )),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: RadiusCardShape(cardRadius: 12,widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.withdrawHistoryScreen);
                      },iconLocation:MyIcons.withdrawNewIcon, text: MyStrings.myWithdrawals),

                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.depositHistoryScreen);
                      },iconLocation:MyIcons.depositNewIcon, text:MyStrings.depositHistory),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.transactionScreen);
                      },iconLocation:MyIcons.transferNewIcon, text:MyStrings.transactions),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.advertisementScreen);
                      },iconLocation:MyIcons.addNewIcon, text:MyStrings.advertisement),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.referralScreen);
                      },iconLocation:MyIcons.referNewIcon,text:MyStrings.referral,showDivider: false),


                    ],
                  )),
                ),
                const CustomSizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: RadiusCardShape(cardRadius: 12,widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                          visible: controller.langSwitchEnable,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MenuRow(
                                iconLocation: MyImages.languageIcon,
                                text: MyStrings.language.tr,
                                press: (){
                                  final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
                                  SharedPreferences pref = apiClient.sharedPreferences;
                                  String language = pref.getString(SharedPreferenceHelper.languageListKey)  ??'';
                                  String countryCode = pref.getString(SharedPreferenceHelper.countryCode)   ??'US';
                                  String languageCode = pref.getString(SharedPreferenceHelper.languageCode) ??'en';
                                  Locale local = Locale(languageCode,countryCode);
                                  showLanguageDialog(language, local, context);
                                  //Get.toNamed(RouteHelper.languageScreen);
                                },
                              ),
                            ],
                          )),
                      MenuRow(press:(){
                        Get.toNamed(RouteHelper.privacyScreen);
                      },iconLocation:MyIcons.policyIconIcon, text:MyStrings.policies),
                      MenuRow(
                        isLoading:controller.logoutLoading,
                        press:(){
                        controller.logout();
                      },iconLocation:MyIcons.logOutIcon, text:MyStrings.signOut,showDivider: false),
                    ],
                  )),
                ),

              ],
            ),
          ),
        )),
        bottomNavigationBar: const CustomBottomNav(
          currentIndex: 4,
        ),
      ),
    ));
  }
}
