import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/trade_shimmer/TradeShimmer.dart';

import '../../../../../../../core/helper/date_converter.dart';
import '../../../../../../../core/helper/string_format_helper.dart';
import '../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/url_container.dart';
import '../../../../../../../data/controller/trade/trade_controller/trade_controller.dart';
import '../../../../../../components/CustomNoDataFoundClass.dart';
import '../trade_list_item/trade_list_item.dart';

class CompleteTradeWidget extends StatefulWidget {
  const CompleteTradeWidget({Key? key}) : super(key: key);

  @override
  State<CompleteTradeWidget> createState() => _CompleteTradeWidgetState();
}

class _CompleteTradeWidgetState extends State<CompleteTradeWidget> {


  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<TradeController>().loadCompleteTrade();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if(Get.find<TradeController>().hasNext(isRunning: false)){
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

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addListener(_scrollListener);
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TradeController>(builder: (controller)=>
    controller.isLoading?
    const Expanded(child:TradeShimmer()):
    controller.completeTradeList.isEmpty?const Expanded(child:  NoDataOrInternetScreen(message2: MyStrings.emptyTradeMsg,)):
    Expanded(
        child:
        RefreshIndicator(
            color: MyColor.primaryColor,
            backgroundColor: MyColor.colorWhite,
            onRefresh: () async {
              controller.completedIndex=0;
              await controller.loadCompleteTrade();
            },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.completeTradeList.length+1,
              controller: _controller,
              itemBuilder: (context, index){

                if(index==controller.completeTradeList.length){
                  return Center(
                    child: controller.hasNext(isRunning: false)?const Padding(padding:EdgeInsets.all(5),child: CircularProgressIndicator(color: MyColor.primaryColor,)):const SizedBox(),
                  );
                }

                return TradeListItem(
                  statusColor: controller.getStatusColor(index,isRunning: false),
                  window: controller.completeTradeList[index].window.toString(),
                  date: DateConverter.getFormatedSubtractTime(controller.completeTradeList[index].createdAt??''),
                  gatewayName: controller.completeTradeList[index].fiatGateway?.name.toString()??'',
                  currency: '${controller.completeTradeList[index].fiat?.code.toString()}/${controller.completeTradeList[index].crypto?.code}',
                  status: controller.getStatus(index,isRunning: false),
                  gatewayImageUrl: '${UrlContainer.baseUrl}${controller.cryptoImagePath}/${controller.completeTradeList[index].fiatGateway?.image}',
                  rate: CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.completeTradeList[index].exchangeRate.toString()),
                  username: controller.getUsername(index,isRunning: false),
                  userImage: controller.getUserImage(index,isRunning: false),
                  tradeType: controller.getTrxType(index,isRunning: false),
                  press: (){
                    Get.toNamed(RouteHelper.tradeDetailsScreen, arguments: controller.completeTradeList[index].uid);
                  },
                );
              }),
        )
    ));
  }
}
