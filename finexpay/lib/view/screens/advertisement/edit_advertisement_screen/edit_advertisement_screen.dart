import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/advertisement/add_advertisement_screen/widget/shimmer/new_advertisement_shimmer.dart';
import 'package:local_coin/view/screens/advertisement/edit_advertisement_screen/widget/crypto_bottom_sheet.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/advertisement_controller/edit_advertisement_controller.dart';
import '../../../../data/repo/advertisement_repo/advertisement_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/label_column/label_column.dart';
import '../../../components/rounded_button.dart';
import '../../../components/show_custom_snackbar.dart';
import '../../transactions/widget/filter_row_widget.dart';
import '../add_advertisement_screen/widget/add_limit_widget.dart';

class EditAdvertisementScreen extends StatefulWidget {
  const
  EditAdvertisementScreen({Key? key}) : super(key: key);

  @override
  State <EditAdvertisementScreen> createState() => _EditAdvertisementScreenState();
}

class _EditAdvertisementScreenState extends State<EditAdvertisementScreen> {
  late GlobalKey<FormState>_globalKey;


  @override
  void initState() {
    int id=Get.arguments;
    _globalKey=GlobalKey<FormState>();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AdvertisementRepo(apiClient: Get.find()));
    final controller= Get.put(EditAdvertisementController(repo: Get.find()));
     controller.advertisementId=id;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
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
                  title: MyStrings.editAdvertisement,
                  isShowBackBtn: true,
                  bgColor: MyColor.transparentColor,
                ),
                body: GetBuilder<EditAdvertisementController>(
                  builder: (controller) =>
                  controller.isLimit?AdvertisementListWidget(errorText: controller.limitMessage,):Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left:Dimensions.screenPadding,right:Dimensions.screenPadding,top: Dimensions.screenPadding ),
                    child: controller.isLoading?const NewAdvertisementShimmer():SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: _globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: LabelColumn(
                                    title: MyStrings.iWantTo,
                                    child: FilterRowWidget(text: controller.selectedTrxType , press: (){
                                      showMyBottomSheet(controller.trxTypeList, '1', context,MyStrings.selectATrxType);
                                    }),
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Expanded(flex:3,child:   LabelColumn(
                                    title: MyStrings.cryptoCurrency,
                                    child: FilterRowWidget(
                                      text: controller.selectedCryptoCurrency.name??'',
                                      press: (){
                                        showMyBottomSheet(controller.cryptoCurrencyList.map((e) => e.name!).toList(), '2', context,MyStrings.selectACryptoCurrency);
                                      },
                                    )
                                )),
                              ],
                            ),
                            const SizedBox(height: 12,),
                            const Divider(color: MyColor.borderColor,),
                            const SizedBox(height: 12,),
                            Text(MyStrings.paymentInformation.tr,style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge),),
                            const SizedBox(height: 30,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child:  LabelColumn(
                                    title: MyStrings.paymentMethod,
                                    child: FilterRowWidget(
                                        text: controller.selectedPaymentMethod.name??'',
                                        press: (){
                                          showMyBottomSheet(controller.paymentMethodList.map((e) => e.name!).toList(), '3', context,'Select a Payment Method');
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Expanded(
                                    child:  LabelColumn(
                                      title: MyStrings.currency,
                                      child: FilterRowWidget(text: controller.selectedFiatCurrency.code.toString(), press: (){
                                        showMyBottomSheet(controller.fiatCurrencyList.map((e) => e.code!).toList(), '4', context,'Select a Fiat Currency');
                                      }),
                                    )
                                ),
                              ],
                            ),
                            const SizedBox(height: 22,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child:  LabelColumn(
                                    title: MyStrings.paymentWindow,
                                    child: FilterRowWidget(
                                        text: controller.selectedPaymentWindow.minute.toString(),
                                        press: (){
                                          showMyBottomSheet(controller.paymentWindowList.map((e) => '${e.minute.toString()} Minutes').toList(), '5', context,'Select A Payment Window');
                                        }
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Expanded(child: LabelColumn(
                                  title: MyStrings.priceType,
                                  child: FilterRowWidget(text: controller.selectedPriceType, press: (){
                                    showMyBottomSheet(controller.priceTypeList.map((e) => e.toString()).toList(), '6', context,'Select A Price Type');
                                  }),
                                )  ),
                              ],
                            ),
                            const SizedBox(height: 22,),
                            LabelColumn(
                                isFixedSize: false,
                                title: controller.selectedPriceType,
                                child: CustomTextFormField(
                                  hintText: '1000',
                                  controller: controller.marginController,
                                  fillColor: MyColor.bgColor1,
                                  inputType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "${controller.selectedPriceType} ${MyStrings.cantBeEmpty}".tr;
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value){
                                    controller.marginOrFixedChange(value);
                                  },
                                )
                            ),
                            const SizedBox(height: 22,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child:  LabelColumn(
                                      isFixedSize: false,
                                      title: MyStrings.minimumLimit,
                                      child: CustomTextFormField(
                                        inputType: TextInputType.number,
                                        controller: controller.minimumController,
                                        fillColor: MyColor.bgColor1,
                                        hintText: '10000',
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return MyStrings.minimumLimitErrorTxt.tr;
                                          }
                                          else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value){

                                        },
                                      )
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Expanded(child:
                                LabelColumn(
                                    isFixedSize: false,
                                    title: MyStrings.maximumLimit.tr,
                                    child: CustomTextFormField(
                                      inputType: TextInputType.number,
                                      controller: controller.maximumController,
                                      fillColor: MyColor.bgColor1,
                                      hintText: '10000',
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return MyStrings.maximumLimitErrorTxt.tr;
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value){

                                      },
                                    )
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 22,),
                            LabelColumn(
                                isFixedSize: false,
                                title: MyStrings.priceEquation.tr,
                                child:Text('${controller.price} ${controller.priceCurrency}',style: mulishSemiBold.copyWith(color: MyColor.primaryColor),)
                            ),
                            const SizedBox(height: 22,),
                            LabelColumn(
                                isFixedSize: false,
                                title: MyStrings.paymentDetails.tr,
                                child: CustomTextFormField(
                                    maxLines: 3,
                                    fillColor: MyColor.bgColor1,
                                    controller: controller.paymentDetailsController,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return MyStrings.paymentDetailsErrorTxt.tr;
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    hintText: MyStrings.paymentDetails.tr.toLowerCase(),
                                    onChanged: (value){

                                    })
                            ),
                            const SizedBox(height: 22,),
                            LabelColumn(
                                isFixedSize: false,
                                title: MyStrings.termsOfTrade,
                                child: CustomTextFormField(
                                    maxLines: 3,
                                    fillColor:  MyColor.bgColor1,
                                    controller: controller.termsOfTradeController,
                                    hintText: MyStrings.termsOfTrade,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return MyStrings.termsOfTradeErrorTxt.tr;
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value){

                                    })
                            ),
                            const SizedBox(height: 35,),

                            controller.storeLoading?const RoundedLoadingBtn():RoundedButton(text: "Submit", press:(){
                              if(_globalKey.currentState!.validate()){
                                if(controller.selectedFiatCurrency.id.toString()!='-1'){
                                  controller.updateAdvertisement();
                                }else{
                                  CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.selectAFiatCurrency], isError: true);
                                }
                              }
                            }),
                            const SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    ),
                  ),)
            )));
  }


}