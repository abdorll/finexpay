import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/trade/trade_controller/trade_controller.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';


import '../../../../../../../core/route/route.dart';
import '../../../../../../../core/utils/my_color.dart';
import '../trade_list_item/trade_list_item.dart';
import '../trade_shimmer/TradeShimmer.dart';



class RunningTradeWidget extends StatefulWidget {
  const RunningTradeWidget({Key? key}) : super(key: key);

  @override
  State<RunningTradeWidget> createState() => _RunningTradeWidgetState();
}

class _RunningTradeWidgetState extends State<RunningTradeWidget> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<TradeController>().loadInitialRunningTrade();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if(Get.find<TradeController>().hasNext(isRunning: true)){
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
           _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TradeController>(builder: (controller)=>
    controller.isLoading?
     const Expanded(child: TradeShimmer()):
        controller.runningTradeList.isEmpty?const Expanded(child: NoDataOrInternetScreen(message2:MyStrings.emptyTradeMsg ,)):
        Expanded(
          child: RefreshIndicator(
            color: MyColor.primaryColor,
            backgroundColor: MyColor.colorWhite,
            onRefresh: () async {
              controller.runningIndex=0;
              await controller.loadInitialRunningTrade();
            },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
           itemCount: controller.runningTradeList.length+1,
            controller: _controller,
            itemBuilder: (context, index){

            if(index==controller.runningTradeList.length){
              return Center(
                child: controller.hasNext(isRunning: true)?const Padding(
                  padding: EdgeInsets.all(5),
                    child: SizedBox(height:40,child:  CircularProgressIndicator(color: MyColor.primaryColor,))):const SizedBox(),
              );
            }
              return   TradeListItem(
                statusColor: controller.getStatusColor(index,isRunning: true),
                window: controller.runningTradeList[index].window.toString(),
                date: DateConverter.getFormatedSubtractTime(controller.runningTradeList[index].createdAt??''),
                gatewayName: controller.runningTradeList[index].fiatGateway?.name.toString()??'',
                currency: '${controller.runningTradeList[index].fiat?.code.toString()}/${controller.runningTradeList[index].crypto?.code}',
                status: controller.getStatus(index,isRunning: true),
                gatewayImageUrl: '${UrlContainer.baseUrl}${controller.cryptoImagePath}/${controller.runningTradeList[index].fiatGateway?.image}',
                rate: CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.runningTradeList[index].exchangeRate.toString()),
                username: controller.getUsername(index,isRunning: true),
                userImage: controller.getUserImage(index,isRunning: true),
                tradeType: controller.getTrxType(index,isRunning: true),
                press: (){
                  Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: controller.runningTradeList[index].uid);
                },
              );
            }),
    ),
        ));
  }
}
