

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/transaction_controller/transaction_controller.dart';
import 'package:local_coin/data/repo/transaction_repo/transaction_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/custom_text_field.dart';
import 'package:local_coin/view/screens/transactions/shimmer/list_shimmer.dart';
import 'package:local_coin/view/screens/transactions/widget/bottom_sheet.dart';
import 'package:local_coin/view/screens/transactions/widget/filter_row_widget.dart';
import 'package:local_coin/view/screens/transactions/widget/transaction_list_item.dart';

import '../../../core/utils/my_color.dart';
import '../../components/app_bar/custom_appbar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {


  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<TransactionController>().loadPaginationData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<TransactionController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(TransactionController(repo: Get.find()));
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page=0;
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
      child: Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: const CustomAppBar(
            title:MyStrings.transactions,
            isShowBackBtn: true,
            isShowActionBtn: true,
          ),
          body: GetBuilder<TransactionController>(
            builder: (controller) => controller.isLoading
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 15),
                      child:  TransactionShimmer()
                  )
                )
                : Padding(
              padding: const EdgeInsets.all(Dimensions.screenPadding),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                      child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: FilterRowWidget(
                                                fromTrx: true,
                                                  text: controller.selectedTrxType.isEmpty?MyStrings.trxType:controller.selectedTrxType,
                                                  press: () {
                                                    showTrxBottomSheet(controller
                                                        .transactionTypeList,1,context: context);
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: FilterRowWidget(
                                                fromTrx: true,
                                                  text: CustomValueConverter.replaceUnderscoreWithSpace(controller.selectedRemark.isEmpty?MyStrings.any:controller.selectedRemark),
                                                  press: () {
                                                    showTrxBottomSheet(controller
                                                        .remarksList.map((e) => e.remark.toString()).toList(),2,context: context);
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: FilterRowWidget(
                                                fromTrx: true,
                                                  text: controller.selectedCrypto.isEmpty?MyStrings.selectACrypto:controller.selectedCrypto,
                                                  press: () {
                                                    showTrxBottomSheet(
                                                        controller.cryptoCurrencyList.map((e) => e.code.toString()).toList(),3, context:context,);
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              //width: 120,
                                              child: Container(
                                                width: 160,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6),
                                                    color: MyColor.transparentColor,
                                                ),
                                                child: CustomTextField(
                                                  horizontalPadding: 2,
                                                  borderWidth: .5,
                                                  verticalPadding: 10,
                                                  maxLines: 1,
                                                  controller: controller.trxController,
                                                  onChanged: (value){

                                                    },
                                                    hintText: MyStrings.trxId,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.filterData();

                                },
                                child: Container(
                                  height: 37,
                                  width: 37,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      color: MyColor.primaryColor,
                                  ),
                                  child: const Icon(Icons.search_outlined,
                                    color:  MyColor.colorWhite,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                          color: MyColor.primaryColor,
                          backgroundColor: MyColor.colorWhite,
                          onRefresh: () async {
                            controller.page=0;
                            await controller.filterData();
                          },
                          child:controller.transactionList.isEmpty&&controller.filterLoading==false? const NoDataOrInternetScreen(message: MyStrings.noTransactionFound,message2: MyStrings.transactionEmptyMsg,):
                          controller.filterLoading?const TransactionShimmer():
                             ListView.builder(
                              controller: _controller,
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.transactionList.length+1,
                                itemBuilder: (context, index) {

                                  if (controller.transactionList.length ==
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

                                  return TransactionListItem(
                                      expandedIndex: controller.expandedIndex,
                                      press: () {},
                                      imagePath:
                                          '${UrlContainer.baseUrl}${controller.assetPath}/${controller.transactionList[index].crypto?.image}',
                                      trxModel:
                                          controller.transactionList[index],
                                      index: index);
                                })),
                          ),

                      ],
                    ),
                  ),
                ),
          )),
    );
  }


}
