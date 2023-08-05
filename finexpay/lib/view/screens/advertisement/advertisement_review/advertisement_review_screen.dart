import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/advertisement_controller/advertisement_reviews_controller.dart';
import 'package:local_coin/view/screens/advertisement/advertisement_review/widget/review_card.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/widget/latest_trade_offer_widget/trade_offer_shimmer.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/repo/advertisement_repo/advertisement_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/CustomNoDataFoundClass.dart';
import '../../../components/app_bar/custom_appbar.dart';


class AdvertisementReviewScreen extends StatefulWidget {
  const AdvertisementReviewScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementReviewScreen> createState() => _AdvertisementReviewScreenState();
}

class _AdvertisementReviewScreenState extends State<AdvertisementReviewScreen> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<AdvertisementReviewController>().initData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<AdvertisementReviewController>().hasNext()) {
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

    int id=Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AdvertisementRepo(apiClient: Get.find()));
    final controller = Get.put(AdvertisementReviewController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.adId=id;
      controller.initData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
            child: Scaffold(
                backgroundColor: MyColor.bgColor,
                appBar: CustomAppBar(
                  title: MyStrings.advertisementReviews,
                  isShowBackBtn: true,
                  bgColor: MyColor.transparentColor,
                ),
                body: GetBuilder<AdvertisementReviewController>(
                  builder: (controller) =>  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                        left: Dimensions.screenPadding,
                        right: Dimensions.screenPadding,
                        top: Dimensions.screenPadding),
                    child:  controller.isLoading
                        ? const AdvertisementShimmer()
                        :controller.reviewList.isEmpty?const NoDataOrInternetScreen(message2: MyStrings.emptyReviewLogMsg,): RefreshIndicator(
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
                          itemCount: controller.reviewList.length+1,
                          itemBuilder: (context, index) {
                            if (controller.reviewList.length ==
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
                            return ReviewCard(
                             model: controller.reviewList[index],
                            );
                          }),
                    )
                    ),
                  ),
                )));
  }
}