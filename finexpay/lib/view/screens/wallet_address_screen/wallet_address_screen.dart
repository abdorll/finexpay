import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/controller/wallet/wallet_address_controller/wallet_address_controller.dart';
import 'package:local_coin/data/repo/wallet_repo/wallet_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/screens/wallet_address_screen/widget/shimmer/wallet_address_shimmer.dart';
import 'package:local_coin/view/screens/wallet_address_screen/widget/wallet_address_list_item.dart';

import 'widget/address_generate_dailog.dart';

class WalletAddressScreen extends StatefulWidget {
  const WalletAddressScreen({Key? key}) : super(key: key);

  @override
  State<WalletAddressScreen> createState() => _WalletAddressScreenState();
}

class _WalletAddressScreenState extends State<WalletAddressScreen> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<WalletAddressController>().loadData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if(Get.find<WalletAddressController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  int walletId=0;
  String titleCode='';
  @override
  void initState() {
    var arg=Get.arguments;
    walletId = arg[0];
    titleCode = arg[1];

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WalletRepo(apiClient: Get.find()));
    final controller = Get.put(WalletAddressController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData(walletId);
      _controller.addListener(_scrollListener);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: CustomAppBar(
          bgColor: MyColor.transparentColor,
          title: '${MyStrings.deposit.tr} $titleCode'.tr,
          isShowBackBtn: true,
          isShowActionBtn: true,
        ),
        body: GetBuilder<WalletAddressController>(
          builder: (controller) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(Dimensions.screenPadding),
            child: controller.isLoading
                ? const WalletAddressShimmer()
                : controller.noInternet?NoDataOrInternetScreen(message2:'',isNoInternet: true,onChanged: (value){
                  if(value){
                    controller.initData(walletId);
                  }
            },): Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical:4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColor.bgColor1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text.rich(TextSpan(
                                  text: "${MyStrings.total.tr} ",
                                  style: robotoRegular.copyWith(
                                      color: MyColor.colorBlack),
                                  children: [
                                    TextSpan(
                                        text: controller.totalAddress,
                                        style: mulishSemiBold.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: MyColor.primaryColor)),
                                    TextSpan(
                                        text: " ${MyStrings.address.tr}".toLowerCase(),
                                        style: robotoRegular.copyWith(overflow: TextOverflow.ellipsis)),
                                  ])),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                  backgroundColor: MyColor.primaryColor),
                              onPressed: () {
                                showAlertDialog(context);
                              },
                              child: Text(
                                MyStrings.generateNewAddress.tr,
                                style: robotoLight.copyWith(
                                    color: MyColor.colorWhite),
                              ),
                            )
                          ],
                        ),
                      ),
                      controller.walletAddressList.isEmpty
                          ? const Expanded(child: NoDataOrInternetScreen(message2: MyStrings.walletAddressEmptyMsg,))
                          : Flexible(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _controller,
                                  itemCount:
                                      controller.walletAddressList.length+1,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {

                                    if(index==controller.walletAddressList.length){
                                      return Center(
                                        child: controller.hasNext()?const SizedBox(height:40,child:  CircularProgressIndicator(color: MyColor.primaryColor,)):const SizedBox(),
                                      );
                                    }
                                    return WalletAddressListItem(
                                        model: controller.walletAddressList[index],
                                      cryptoImagePath: '${UrlContainer.baseUrl}${controller.imagePath}',
                                    );
                                  })),
                    ],
                  ),
          ),
        ));
  }


}
