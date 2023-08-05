import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/data/controller/filter_controller/filter_controller.dart';
import 'package:local_coin/data/repo/filter/filter_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/custom_text_field.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/screens/advertisement/add_advertisement_screen/widget/shimmer/new_advertisement_shimmer.dart';
import 'package:local_coin/view/screens/filter_screen/widget/filter_bottom_sheet.dart';

import '../../components/label_column/label_column.dart';
import '../transactions/widget/filter_row_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  @override
  void initState() {

    
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FilterRepo(apiClient: Get.find()));
    final controller=Get.put(FilterController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.initData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      appBar: const CustomAppBar(title: MyStrings.filterAdvertisement,isShowBackBtn: true,isShowActionBtn: true),
      body:GetBuilder<FilterController>(builder: (controller)=>
      SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: controller.isLoading?const NewAdvertisementShimmer():controller.noInternet?NoDataOrInternetScreen(isNoInternet: true,onChanged: (value){
            if(value){
              controller.changeNoInternetStatus(false);
              controller.initData();
            }
          },): controller.cryptoCurrencyList.isEmpty?const Expanded(child: NoDataOrInternetScreen(message: MyStrings.somethingWentWrong,message2: MyStrings.goBackLogMsg,)) :
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top:Dimensions.screenPadding,right:Dimensions.screenPadding,left: Dimensions.screenPadding ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LabelColumn(
                          title: '${MyStrings.trxType} ',
                          child: FilterRowWidget( iconColor: MyColor.colorBlack,
                              text: controller.selectedTrxType,
                              press: () {
                                FilterBottomSheet.showModal(controller.trxTypeList,MyStrings.selectATrxType, context, 0);
                              }),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(

                          child: LabelColumn(
                              title: MyStrings.cryptoCurrency,
                              child: FilterRowWidget( iconColor: MyColor.colorBlack,
                                text: controller
                                    .selectedCrypto,
                                press: () {
                                  FilterBottomSheet.showModal(controller.cryptoCurrencyList.map((e) => e.code.toString()).toList(),MyStrings.selectACryptoCurrency, context, 1);
                                },
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LabelColumn(
                          isRequired: false,
                          title: MyStrings.paymentMethod,
                          child: FilterRowWidget(
                              iconColor: MyColor.tileColor,
                              text: controller
                                  .selectedPaymentMethod,
                              press: () {
                                FilterBottomSheet.showModal(controller.paymentMethodList.map((e) => e.name.toString()).toList(),MyStrings.selectAPaymentMethod, context, 2);
                              }),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: LabelColumn(
                            isRequired: false,
                              title: MyStrings.fiatCurrency,
                              child: FilterRowWidget( iconColor: MyColor.colorBlack,
                                text: controller
                                    .selectedFiatCurrency,
                                press: () {
                                  FilterBottomSheet.showModal(controller.fiatList.map((e) => e.code.toString()).toList(),MyStrings.selectAFiatCurrency, context, 3);
                                },
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LabelColumn(
                          title: MyStrings.offerLocation,
                          child: FilterRowWidget( iconColor: MyColor.colorBlack,
                              text: controller
                                  .selectedCountry,
                              press: () {
                                FilterBottomSheet.showModal(controller.countryList.map((e) => e.country.toString()).toList(),MyStrings.selectAOfferLocation, context, 4);
                              }),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: LabelColumn(
                              title: MyStrings.amount,
                              child: CustomTextField(
                                borderRadius: 6,
                                enableOutlineColor: MyColor.borderColor,
                                hintText: '10.0',
                                inputType: TextInputType.number,
                                fillColor: MyColor.bgColor1,
                                onChanged: (value){

                              }))),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.35,),
                  RoundedButton(text: MyStrings.filterNow, press:(){
                    controller.canGo();
                  }),
                const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),)
    );
  }

}
