import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/data/repo/withdraw/withdraw_repo.dart';
import 'package:local_coin/view/components/custom_text_field.dart';
import 'package:local_coin/view/screens/account/deposit_history_screen/widget/crypto_bottom.dart';
import 'package:local_coin/view/screens/account/withdrawls_history_screen/widget/withdraw_history_list_item/withdraw_history_list_item.dart';
import 'package:local_coin/view/screens/transactions/shimmer/list_shimmer.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../constants/my_strings.dart';
import '../../../../data/controller/withdraw/withdraw_history_controller.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/CustomNoDataFoundClass.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/label_column/label_column.dart';
import '../../transactions/widget/filter_row_widget.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  const WithdrawHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawHistoryScreen> createState() => _WithdrawHistoryScreenState();
}

class _WithdrawHistoryScreenState extends State<WithdrawHistoryScreen> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<WithdrawHistoryController>().fetchNewList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if( Get.find<WithdrawHistoryController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<WithdrawHistoryController>().clearData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    final controller=Get.put(WithdrawHistoryController(repo: Get.find()));
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
     controller.initData();
     _controller.addListener(_scrollListener);
    });

  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawHistoryController>(
        builder: (controller) => Scaffold(
              backgroundColor: MyColor.bgColor,
              appBar:  CustomAppBar(
                bgColor: MyColor.transparentColor,
                title: MyStrings.withdrawals,
              ),
              body:Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child:  controller.isLoading
                    ? const SizedBox(child: TransactionShimmer(),) : Column(
                  children: [

                    IntrinsicHeight(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child:  Row(
                            children: [
                              Expanded(
                                child: LabelColumn(
                                  height: 40,
                                  title: MyStrings.trxId,
                                  child:CustomTextField(
                                    fillColor: MyColor.bgColor1,
                                    horizontalPadding: 3,
                                    borderWidth: .5,
                                    controller: controller.trxController,
                                    verticalPadding: 10,
                                    hintText: MyStrings.ex,
                                    onChanged: (value){

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
                                        CustomBottomSheet.showDepositSheet(
                                                      controller.cryptoCurrencyList
                                                          .map((e) => e.code.toString())
                                                          .toList(),
                                                      MyStrings.selectACryptoCurrency,
                                                      context,fromDeposit: false);
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
                                      Icons.search_outlined,
                                      size: 20,
                                      color: MyColor.colorWhite,
                                    ),
                                    onPressed: () {
                                      controller.filterData();
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
                    Expanded(
                      child:  RefreshIndicator(
                        color: MyColor.primaryColor,
                        backgroundColor: MyColor.colorWhite,
                        onRefresh: () async {

                          await controller.filterData();
                        },
                        child:controller.filterLoading? const TransactionShimmer(): controller.withdrawList.isEmpty?  const NoDataOrInternetScreen(message2: MyStrings.emptyWithdrawHistoryMsg,): ListView.builder(
                              itemCount: controller.withdrawList.length + 1,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _controller,
                              itemBuilder: (builder, index) {
                                if (index == controller.withdrawList.length) {
                                  return Center(
                                    child: controller.hasNext()
                                        ? const Padding(
                                      padding: EdgeInsets.all(10),
                                        child: CircularProgressIndicator(color: MyColor.primaryColor,))
                                        : const SizedBox(),
                                  );
                                }
                                return WithdrawHistoryListItem(
                                  status: controller.getStatus(controller.withdrawList[index].status??''),
                                  statusBG:controller.getBgColor(controller.withdrawList[index].status??'') ,
                                  expandIndex:controller.expandIndex,
                                  listItem: controller.withdrawList[index], index: index,imagePath: '${controller.cryptoImagePath}${controller.withdrawList[index].crypto?.image}',);
                              }),
                      ),

                    ),
                  ],
                ),
              )
            ));
  }





}
