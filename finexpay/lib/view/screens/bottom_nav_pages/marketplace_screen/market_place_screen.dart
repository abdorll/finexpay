import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/market_place_controller/market_place_controller.dart';
import 'package:local_coin/data/repo/marketplace_repo/market_place_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/bottom_Nav/bottom_nav.dart';
import 'package:local_coin/view/components/custom_container/custom_container.dart';
import 'package:local_coin/view/components/label_column/label_column.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';
import 'package:local_coin/view/components/will_pop_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/marketplace_screen/widget/bottom_sheet.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/marketplace_screen/widget/market_place_shimmer.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/trade_shimmer/TradeShimmer.dart';
import 'package:local_coin/view/screens/transactions/widget/filter_row_widget.dart';

import '../../../../core/helper/shared_pref_helper.dart';
import '../../../components/buttons/circle_button_with_icon.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<MarketPlaceController>().loadTransaction();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<MarketPlaceController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MarketplaceRepo(apiClient: Get.find()));
    final controller = Get.put(MarketPlaceController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const CustomAppBar(title: MyStrings.marketplace,isShowActionBtn: true,isShowBackBtn: false,),
        body: GetBuilder<MarketPlaceController>(
            builder: (controller) => controller.isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const MarketPlaceShimmer())
                :
            Container(
                    padding: const EdgeInsets.all(Dimensions.screenPadding),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: LabelColumn(
                                    height: 40,
                                    title: MyStrings.trxType,
                                    child: FilterRowWidget(
                                        text: controller.selectedType,
                                        press: () {
                                          CustomBottomSheet.showMarketSheet(
                                            controller.typeList,
                                            MyStrings.selectATrxType,
                                            context,
                                            isCurrency: false,
                                          );
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: LabelColumn(
                                    height: 40,
                                    title: MyStrings.cryptoCurrency,
                                    child: FilterRowWidget(
                                        text: controller.selectedCrypto,
                                        press: () {
                                          CustomBottomSheet.showMarketSheet(
                                              controller.cryptoCurrencyList
                                                  .map((e) => e.code.toString())
                                                  .toList(),
                                              MyStrings.selectACryptoCurrency,
                                              context);
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 40,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(left: 3, right: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: MyColor.primaryColor,
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(
                                        Icons.filter_alt_outlined,
                                        size: 22,
                                        color: MyColor.colorWhite,
                                      ),
                                      onPressed: () {
                                        Get.toNamed(RouteHelper.filterScreen);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.trxLoading
                            ? const Expanded(
                                child: TradeShimmer())
                            : controller.advertisementList.isEmpty
                                ?  const Expanded(
                                    child: NoDataOrInternetScreen(
                                      imageHeight: 0.3,
                                      message2: MyStrings.emptyAdvertisementLogMsg,
                                    ),
                                  )
                                : Expanded(
                                    child: RefreshIndicator(
                                      color: MyColor.primaryColor,
                                      backgroundColor: MyColor.colorWhite,
                                      onRefresh: () async {
                                        controller.page=0;
                                        controller.loadTransaction();
                                      },
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          controller: _controller,
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          itemCount:
                                              controller.advertisementList.length +
                                                  1,
                                          itemBuilder: (context, index) {
                                            if (controller
                                                    .advertisementList.length ==
                                                index) {

                                              return controller.hasNext()
                                                  ? Center(
                                                      child:
                                                         Container(
                                                           padding: const EdgeInsets.all(5),
                                                           height: 32,
                                                           width: 32,
                                                           child: const CircularProgressIndicator(color: MyColor.primaryColor,)),
                                                          )
                                                  : const SizedBox();
                                            }

                                            bool myAdds = controller
                                                    .advertisementList[index].userUsername
                                                    .toString() ==
                                                controller.repo.apiClient
                                                    .sharedPreferences
                                                    .getString(
                                                        SharedPreferenceHelper
                                                            .userNameKey);
                                            return GestureDetector(
                                              onTap: () {
                                                if (myAdds) {
                                                  CustomSnackbar.showCustomSnackbar(
                                                      errorList: [
                                                        MyStrings
                                                            .ownTradeErrorMessage
                                                      ],
                                                      msg: [],
                                                      isError: true);
                                                } else {
                                                  Get.toNamed(
                                                      RouteHelper.makeATradeScreen,
                                                      arguments: controller
                                                          .advertisementList[index]
                                                          .id);
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 15),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:MyColor.transparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .cornerRadius),
                                                    border: Border.all(
                                                        color: MyColor.borderColor,
                                                        width: 1)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                       Expanded(child: GestureDetector(
                                                          onTap: (){
                                                            Get.toNamed(RouteHelper.clientProfileScreen,arguments: controller
                                                                .advertisementList[
                                                            index]
                                                                .userUsername ??'');
                                                          },
                                                          child: Row(
                                                            children: [
                                                             CircleButtonWithIcon(isAsset: false,isIcon: false,bg: MyColor.bgColor1,
                                                               press: (){},
                                                               circleSize: 20,
                                                               imageSize: 20,
                                                               padding: 0,
                                                               imagePath: '${controller.advertisementList[index].userImage}'),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  controller
                                                                          .advertisementList[
                                                                              index]
                                                                          .userUsername ??
                                                                      '',
                                                                  style: mulishRegular,
                                                                  overflow: TextOverflow.ellipsis,

                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                       const SizedBox(width: 20,),
                                                       Text(
                                                          '${MyStrings.window.tr}: ${controller
                                                              .advertisementList[
                                                          index]
                                                              .window ??
                                                              ''}'.tr,
                                                          style:
                                                          robotoRegular.copyWith(color: MyColor.textColor,fontSize: Dimensions.fontDefault2),
                                                          textAlign:
                                                          TextAlign.end,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                   CustomContainer(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleButtonWithIcon(
                                                                padding: Dimensions.gatewayPadding,
                                                                imageSize: Dimensions.gatewayImageSize-Dimensions.gatewayPadding,
                                                                circleSize: Dimensions.gatewayImageSize,
                                                                press: () {},
                                                                imagePath:
                                                                    '${controller.advertisementList[index].fiatGatewayImage}',
                                                                bg: MyColor.colorWhite,
                                                                isAsset: false,
                                                                isIcon: false,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                controller
                                                                        .advertisementList[
                                                                            index]
                                                                        .fiatGateway ??
                                                                    '',
                                                                style:
                                                                mulishRegular
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment.bottomRight,
                                                              child: Text(
                                                                "${MyStrings.rate.tr}: ${controller.advertisementList[index].rate ??'00'}\n${controller.advertisementList[index].rateCurrency }",
                                                                textAlign: TextAlign.end,
                                                                style: mulishRegular
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex:3,
                                                          child:  Text(
                                                            "${MyStrings.limit.tr}: ${controller.advertisementList[index].maxLimit ?? '0'}",
                                                            style:robotoRegular.copyWith(color: MyColor.colorGrey2,fontSize: Dimensions.fontSmall),
                                                            overflow: TextOverflow.ellipsis,
                                                          )
                                                           ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            '${MyStrings.avg.tr}: ${controller
                                                                .advertisementList[
                                                            index]
                                                                .avgSpeed ??
                                                                '--'}',
                                                            style:
                                                            robotoRegular.copyWith(color: MyColor.colorGrey2,fontSize: Dimensions.fontDefault2),
                                                            textAlign:
                                                            TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                      ],
                    ),
                  )),
        bottomNavigationBar: const CustomBottomNav(
          currentIndex: 2,
        ),
      ),
    );
  }
}
