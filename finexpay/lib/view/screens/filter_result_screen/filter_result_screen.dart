import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/data/controller/filter_controller/filter_result_controller.dart';
import 'package:local_coin/data/repo/filter/filter_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/marketplace_screen/widget/market_place_shimmer.dart';

import '../../../core/utils/styles.dart';
import '../../components/buttons/circle_button_with_icon.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({Key? key}) : super(key: key);

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<FilterResultController>().loadData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<FilterResultController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late var argument;
  @override
  void initState() {

    argument = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FilterRepo(apiClient: Get.find()));
    final controller = Get.put(FilterResultController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.loadData(argument: argument);
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const CustomAppBar(
          title: MyStrings.searchResult,
          isShowBackBtn: true,
          isShowActionBtn: true,
        ),
        body: GetBuilder<FilterResultController>(
          builder: (controller) => Container(
            padding: const EdgeInsets.all(Dimensions.screenPadding),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? const MarketPlaceShimmer()
                : controller.advertisementList.isEmpty
                    ? const NoDataOrInternetScreen(message2: MyStrings.emptyAdvertisementLogMsg,)
                    : RefreshIndicator(
                        color: MyColor.primaryColor,
                        backgroundColor: MyColor.colorWhite,
                        onRefresh: () async {
                          controller.page = 0;
                          controller.loadData(argument: argument);
                        },
                        child: SizedBox(
                          child: ListView.builder(
                              shrinkWrap: true,
                              controller: _controller,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  controller.advertisementList.length + 1,
                              itemBuilder: (context, index) {
                                if (controller.advertisementList.length ==
                                    index) {
                                  return controller.hasNext()
                                      ? const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                              child: CircularProgressIndicator(color: MyColor.primaryColor,)))
                                      : const SizedBox();
                                }

                                bool isMyAds = controller
                                        .advertisementList[index].userUsername
                                        .toString() ==
                                    controller.repo.apiClient.sharedPreferences
                                        .getString(
                                            SharedPreferenceHelper.userNameKey);
                                return InkWell(
                                  onTap: () {
                                    if (isMyAds) {
                                      CustomSnackbar.showCustomSnackbar(
                                          errorList: [MyStrings.ownTradeErrorMessage],
                                          msg: [],
                                          isError: true);
                                    } else {
                                      Get.toNamed(RouteHelper.makeATradeScreen, arguments: controller.advertisementList[index].id);
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: MyColor.colorWhite,
                                        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                                        border: Border.all(color: MyColor.borderColor, width: 1)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child:GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteHelper.clientProfileScreen,arguments: controller.advertisementList[index].userUsername ??'');
                                              },
                                              child: Row(
                                                children: [
                                                  CircleButtonWithIcon(
                                                    isAsset: false,
                                                    isIcon: false,
                                                    bg: MyColor.transparentColor,
                                                    press: () {},
                                                    circleSize: 20,
                                                    imageSize: 20,
                                                    padding: 0,
                                                    imagePath: '${controller.advertisementList[index].userImage}',
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      controller.advertisementList[index].userUsername ?? '',
                                                      style: mulishRegular,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            const SizedBox(width: 15,),
                                            Text(
                                              '${MyStrings.window.tr}: ${controller
                                                  .advertisementList[
                                              index]
                                                  .window ??
                                                  ''}',
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
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color:  MyColor.bgColor1),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                    style:  mulishRegular
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
                                          MainAxisAlignment.spaceBetween,
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
                                              child: Text(
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
                                    ]
                                  )),
                                );
                              }),
                        ),
                      ),
          ),
        ));
  }
}
