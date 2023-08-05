import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/custom_text_field.dart';
import 'package:local_coin/view/screens/account/deposit_history_screen/widget/crypto_bottom.dart';
import 'package:local_coin/view/screens/account/deposit_history_screen/widget/payment_log_list_item/deposit_history_list_item.dart';

import '../../../../../../../core/utils/my_color.dart';
import '../../../../constants/my_strings.dart';
import '../../../../data/controller/deposit_controller/deposit_controller.dart';
import '../../../../data/repo/deposit_repo/deposit_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/CustomNoDataFoundClass.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/label_column/label_column.dart';
import '../../transactions/shimmer/list_shimmer.dart';
import '../../transactions/widget/filter_row_widget.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if( Get.find<DepositController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<DepositController>().clearData();

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
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller=Get.put(DepositController(repo: Get.find()));
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.page=0;
     controller.initData();
      _controller.addListener(_scrollListener);
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
        builder: (controller) => Scaffold(
              backgroundColor: MyColor.bgColor,
              appBar:  CustomAppBar(
                bgColor: MyColor.transparentColor,
                title: MyStrings.depositHistory,
              ),
              body:Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: controller.isLoading
                    ? const SizedBox(child: TransactionShimmer(),) : Column(
                  children: [

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: IntrinsicHeight(
                        child: Row(
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
                     controller.filterLoading? const Expanded(child: TransactionShimmer()): controller.depositList.isEmpty? const Expanded(child:  NoDataOrInternetScreen(message2: MyStrings.emptyDepositHistoryMsg,)): Expanded(
                       child: RefreshIndicator(
                         color: MyColor.primaryColor,
                         backgroundColor: MyColor.colorWhite,
                         onRefresh: () async {
                           controller.page=0;
                           await controller.fetchNewList();
                         },
                         child: ListView.builder(
                               itemCount: controller.depositList.length + 1,
                               shrinkWrap: true,
                               physics: const AlwaysScrollableScrollPhysics(),
                               controller: _controller,
                               itemBuilder: (builder, index) {
                                 if (index == controller.depositList.length) {
                                   return Center(
                                     child: controller.hasNext()
                                         ? const Padding(
                                       padding: EdgeInsets.all(10),
                                         child: CircularProgressIndicator(color: MyColor.primaryColor,))
                                         : const SizedBox(),
                                   );
                                 }
                                 //status always one so we don't need to check it
                                 return DepositHistoryListItem(
                                   expandIndex:controller.expandIndex,
                                   listItem: controller.depositList[index],
                                   index: index,
                                   imagePath: '${controller.cryptoImagePath}${controller.depositList[index].crypto?.image}',
                                 );
                               }),
                       ),
                     ),
                  ],
                ),
              )
            ));
  }





}
