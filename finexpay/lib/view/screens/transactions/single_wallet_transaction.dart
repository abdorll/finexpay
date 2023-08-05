import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/data/controller/transaction_controller/single_transaction_controller.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/screens/transactions/shimmer/list_shimmer.dart';
import 'package:local_coin/view/screens/transactions/single_transaction_list_item.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/url_container.dart';
import '../../../data/repo/transaction_repo/transaction_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/app_bar/custom_appbar.dart';

class SingleWalletTransactionScreen extends StatefulWidget {
  const SingleWalletTransactionScreen({Key? key}) : super(key: key);

  @override
  State<SingleWalletTransactionScreen> createState() =>
      _SingleWalletTransactionScreenState();
}

class _SingleWalletTransactionScreenState
    extends State<SingleWalletTransactionScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<SingleTransactionController>().loadInitialTransaction();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<SingleTransactionController>().hasNext()) {
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

    
    String id = Get.arguments ?? "-1";

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(SingleTransactionController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.currentPage=0;
      controller.initData(int.tryParse(id) ?? -1);
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const CustomAppBar(
          title: MyStrings.transaction,
          isShowBackBtn: true,
          isShowActionBtn: true,
        ),
        body: GetBuilder<SingleTransactionController>(
          builder: (controller) => Container(
            padding: const EdgeInsets.all(Dimensions.screenPadding),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? const TransactionShimmer()
                :controller.transactionList.isEmpty?const NoDataOrInternetScreen(message2: MyStrings.transactionEmptyMsg,): SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              controller: _controller,
                              itemCount: controller.transactionList.length + 1,
                              itemBuilder: ((context, index) {
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
                                return SingleTransactionListItem(
                                    expandedIndex: controller.expandedIndex,
                                    press: () {},
                                    imagePath:
                                        '${UrlContainer.baseUrl}${controller.assetPath}/${controller.transactionList[index].crypto?.image}',
                                    trxModel: controller.transactionList[index],
                                    index: index);
                              })),
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
