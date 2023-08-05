import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/data/controller/advertisement_controller/advertisement_controller.dart';
import 'package:local_coin/data/repo/advertisement_repo/advertisement_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/screens/advertisement/widget/advertisement_list_item.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_trade_offer_widget/trade_offer_shimmer.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';
import '../../components/app_bar/custom_appbar.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<AdvertisementController>().initData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<AdvertisementController>().hasNext()) {
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
    Get.put(AdvertisementRepo(apiClient: Get.find()));
   final controller= Get.put(AdvertisementController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page=0;
      controller.initData();
      _controller.addListener(_scrollListener);
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColor.bgColor,
      appBar: CustomAppBar(
        title: MyStrings.advertisement,
        isShowBackBtn: true,
        bgColor: MyColor.transparentColor,
      ),
      body: GetBuilder<AdvertisementController>(
          builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenPadding),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:controller.isLoading?const AdvertisementShimmer():  Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.bgColor1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(TextSpan(
                            text: "${MyStrings.total} ",
                            style: robotoRegular.copyWith(color: MyColor.colorBlack),
                            children: [
                              TextSpan(
                                  text: "${controller.totalAdvertisement} ",
                                  style: mulishSemiBold.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: MyColor.primaryColor)),
                              TextSpan(
                                  text: MyStrings.ads,
                                  style: mulishRegular.copyWith(
                                   color: MyColor.colorBlack),),
                            ])),
                        InkWell(
                          onTap:(){
                             Get.toNamed(RouteHelper.newAdvertisementScreen)?.then((value){
                               controller.page=0;
                               controller.initData();
                             });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MyColor.primaryColor),
                            child: Text(
                              MyStrings.addAdvertisement.tr,
                              style: robotoLight.copyWith(color: MyColor.colorWhite),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  controller.advertisementList.isEmpty?const Expanded(child:  NoDataOrInternetScreen(message:MyStrings.noAdvertisementFound,message2: MyStrings.emptyAdvertisementLogMsg,)):  Flexible(
                      child: RefreshIndicator(
                        color: MyColor.primaryColor,
                        backgroundColor: MyColor.colorWhite,
                        onRefresh: () async {
                          controller.page=0;
                          await controller.initData();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: _controller,
                            itemCount: controller.advertisementList.length+1,
                            itemBuilder: (context, index) {
                              if (controller.advertisementList.length ==
                                  index) {
                                return controller.hasNext()
                                    ? SizedBox(
                                  height: 40,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  child: const Center(
                                      child:
                                      CircularProgressIndicator(color: MyColor.primaryColor,)),
                                )
                                    : const SizedBox();
                              }
                              return AdvertisementListItem(
                                gatewayImagePath:'${controller.advertisementList[index].fiatGatewayImage}',
                                cryptoImagePath: '${controller.advertisementList[index].cryptoImage}',
                                index: index,
                                ad: controller.advertisementList[index],
                              );
                            }),
                      )),
                ],
              ))),
    );

  }
}
