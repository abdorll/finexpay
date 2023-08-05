import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/referral_controller/referral_controller.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/trade_shimmer/TradeShimmer.dart';
import 'package:local_coin/view/screens/referral/widget/commision_list_item.dart';

class CommissionWidget extends StatefulWidget {
  const CommissionWidget({Key? key}) : super(key: key);

  @override
  State<CommissionWidget> createState() => _CommissionWidgetState();
}

class _CommissionWidgetState extends State<CommissionWidget> {


  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<ReferralController>().loadInitialReferralCommission();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if(Get.find<ReferralController>().hasNext(false)){
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
    final controller = Get.find<ReferralController>();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.commissionIndex=0;
      controller.loadInitialReferralCommission();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferralController>(
        builder: (controller) => controller.isLoading
            ? const Expanded(
                child: TradeShimmer(),
        ) :controller.referralCommissionList.isEmpty?const Expanded(child: NoDataOrInternetScreen(message2: MyStrings.emptyCommissionLogMsg,))
            :  Flexible(
              child: ListView.builder(
                controller: _controller,
                      itemCount: controller.referralCommissionList.length+1,
                      itemBuilder: ((context, index) {
                        if(index==controller.referralCommissionList.length){
                          return Center(
                            child: controller.hasNext(false)? const CircularProgressIndicator(color:MyColor.primaryColor,):const SizedBox(),
                          );
                        }
                        return CommissionListItem(
                            index: index,
                            imagePath: "${UrlContainer.baseUrl}${controller.cryptoImagePath}/${controller.referralCommissionList[index].crypto?.image}",
                            model: controller.referralCommissionList[index]);
                      })),
            ),
              );
  }
}
