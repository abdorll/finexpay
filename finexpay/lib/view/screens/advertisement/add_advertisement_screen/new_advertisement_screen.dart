import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/advertisement_controller/new_advertisement_controller.dart';
import 'package:local_coin/data/repo/advertisement_repo/advertisement_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/custom_text_form_field.dart';
import 'package:local_coin/view/components/label_column/label_column.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/advertisement/add_advertisement_screen/widget/add_limit_widget.dart';
import 'package:local_coin/view/screens/advertisement/add_advertisement_screen/widget/crypto_bottom_sheet.dart';
import 'package:local_coin/view/screens/advertisement/add_advertisement_screen/widget/shimmer/new_advertisement_shimmer.dart';
import 'package:local_coin/view/screens/transactions/widget/filter_row_widget.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/rounded_button.dart';

class NewAdvertisementScreen extends StatefulWidget {
  const NewAdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<NewAdvertisementScreen> createState() => _NewAdvertisementScreenState();
}

class _NewAdvertisementScreenState extends State<NewAdvertisementScreen> {
  late GlobalKey<FormState> _globalKey;

  @override
  void initState() {
    _globalKey = GlobalKey<FormState>();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AdvertisementRepo(apiClient: Get.find()));
    final controller = Get.put(NewAdvertisementController(repo: Get.find()));

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
                  title: MyStrings.newAdvertisement,
                  isShowBackBtn: true,
                  bgColor: MyColor.transparentColor,
                ),
                body: GetBuilder<NewAdvertisementController>(
                  builder: (controller) => controller.isLimit
                      ? AdvertisementListWidget(
                          errorText: controller.limitMessage.tr,
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              left: Dimensions.screenPadding,
                              right: Dimensions.screenPadding,
                              top: Dimensions.screenPadding),
                          child: controller.noInternet
                              ? NoDataOrInternetScreen(
                                  isNoInternet: true,
                                  onChanged: (value) {
                                    if (value) {
                                      controller.changeNoInternetStatus(false);
                                      controller.initData();
                                    }
                                  })
                              : controller.isLoading
                                  ? const NewAdvertisementShimmer()
                                  : SingleChildScrollView(
                                      child: Form(
                                        key: _globalKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: LabelColumn(
                                                    title: MyStrings.iWantTo,
                                                    child: FilterRowWidget(
                                                        text: controller
                                                            .selectedTrxType,
                                                        press: () {
                                                          showMyBottomSheet(
                                                              controller
                                                                  .trxTypeList,
                                                              '1',
                                                              context,
                                                            MyStrings.selectATrxType
                                                              );
                                                        }),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: LabelColumn(
                                                      press: (){

                                                      },
                                                        title:
                                                            MyStrings.cryptoCurrency,
                                                        child: FilterRowWidget(
                                                          text: controller
                                                                  .selectedCryptoCurrency
                                                                  .code ??
                                                              '',
                                                          press: () {
                                                            showMyBottomSheet(
                                                                controller
                                                                    .cryptoCurrencyList
                                                                    .map((e) =>
                                                                        e.name!)
                                                                    .toList(),
                                                                '2',
                                                                context,
                                                                MyStrings.selectACryptoCurrency);
                                                          },
                                                        ))),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            const Divider(
                                              color: MyColor.borderColor,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                             MyStrings.paymentInformation,
                                              style: mulishSemiBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontLarge),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: LabelColumn(
                                                    title: MyStrings.paymentMethod,
                                                    child: FilterRowWidget(
                                                        text: controller
                                                                .selectedPaymentMethod
                                                                .name ??
                                                            '',
                                                        press: () {
                                                          showMyBottomSheet(
                                                              controller
                                                                  .paymentMethodList
                                                                  .map((e) =>
                                                                      e.name!)
                                                                  .toList(),
                                                              '3',
                                                              context,
                                                              MyStrings.selectAPaymentMethod);
                                                        }),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Expanded(
                                                    child: LabelColumn(
                                                  title:  MyStrings.fiatCurrency,
                                                  child: FilterRowWidget(
                                                      text: controller
                                                          .selectedFiatCurrency
                                                          .code
                                                          .toString(),
                                                      press: () {
                                                        showMyBottomSheet(
                                                            controller
                                                                .fiatCurrencyList
                                                                .map((e) =>
                                                                    e.code!)
                                                                .toList(),
                                                            '4',
                                                            context,
                                                            MyStrings.selectAFiatCurrency);
                                                      }),
                                                )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: LabelColumn(
                                                    title: MyStrings.paymentWindow,
                                                    child: FilterRowWidget(
                                                        text: controller
                                                            .selectedPaymentWindow
                                                            .minute
                                                            .toString(),
                                                        press: () {
                                                          showMyBottomSheet(
                                                              controller
                                                                  .paymentWindowList
                                                                  .map((e) =>
                                                                      '${e.minute.toString()} ${e.id == -1 ? '' : 'Minutes'}')
                                                                  .toList(),
                                                              '5',
                                                              context,
                                                              MyStrings.selectAPaymentWindow);
                                                        }),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Expanded(
                                                    child: LabelColumn(
                                                  title: MyStrings.priceType,
                                                  child: FilterRowWidget(
                                                      text:
                                                          controller.priceType,
                                                      press: () {
                                                        showMyBottomSheet(
                                                            controller
                                                                .priceTypeList
                                                                .map((e) => e
                                                                    .toString())
                                                                .toList(),
                                                            '6',
                                                            context,
                                                          MyStrings.selectAPriceType
                                                            );
                                                      }),
                                                )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            LabelColumn(
                                                isFixedSize: false,
                                                title:
                                                    controller.priceType,
                                                child: CustomTextFormField(
                                                  hintText: '10',
                                                  controller: controller.marginController,
                                                  fillColor: MyColor.bgColor1,
                                                  inputType: TextInputType.number,
                                                  validator: (String? value) {
                                                    if (value!.isEmpty) {
                                                      return "${controller.priceType} ${MyStrings.cantBeEmpty.tr}".tr;
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    controller
                                                        .marginOrFixedChange(
                                                            value);
                                                  },
                                                )),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: LabelColumn(
                                                      isFixedSize: false,
                                                      title: MyStrings.minimumLimit,
                                                      child:
                                                          CustomTextFormField(
                                                        inputType: TextInputType
                                                            .number,
                                                        controller: controller
                                                            .minimumController,
                                                        fillColor:
                                                            MyColor.bgColor1,
                                                        hintText: '1',
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return MyStrings
                                                                .minimumLimitErrorTxt.tr;
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        onChanged: (value) {},
                                                      )),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Expanded(
                                                  child: LabelColumn(
                                                      isFixedSize: false,
                                                      title: MyStrings.maximumLimit,
                                                      child:
                                                          CustomTextFormField(
                                                        inputType: TextInputType
                                                            .number,
                                                        controller: controller
                                                            .maximumController,
                                                        fillColor:
                                                            MyColor.bgColor1,
                                                        hintText: '1000',
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return MyStrings
                                                                .maximumLimitErrorTxt.tr;
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        onChanged: (value) {},
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            LabelColumn(
                                                isFixedSize: false,
                                                title: MyStrings.priceEquation,
                                                child: Text(
                                                  '${controller.price} ${controller.priceCurrency}',
                                                  style:
                                                      mulishSemiBold.copyWith(
                                                          color: MyColor
                                                              .primaryColor),
                                                )),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            LabelColumn(
                                                isFixedSize: false,
                                                title: MyStrings.paymentDetails,
                                                child: CustomTextFormField(
                                                    maxLines: 3,
                                                    fillColor: MyColor.bgColor1,
                                                    controller: controller
                                                        .paymentDetailsController,
                                                    validator: (String? value) {
                                                      if (value!.isEmpty) {
                                                        return MyStrings
                                                            .paymentDetailsErrorTxt;
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    hintText: MyStrings.writeYourPaymentDetails,
                                                    onChanged: (value) {})),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            LabelColumn(
                                                isFixedSize: false,
                                                title: MyStrings.termsOfTrade,
                                                child: CustomTextFormField(
                                                    maxLines: 3,
                                                    fillColor: MyColor.bgColor1,
                                                    controller: controller
                                                        .termsOfTradeController,
                                                    hintText:MyStrings.writeYourTermsOfTrade,
                                                    validator: (String? value) {
                                                      if (value!.isEmpty) {
                                                        return MyStrings
                                                            .termsOfTradeErrorTxt.tr;
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    onChanged: (value) {})),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            controller.storeLoading
                                                ? const RoundedLoadingBtn()
                                                : RoundedButton(
                                                    text: MyStrings.submit,
                                                    press: () {
                                                      if (_globalKey
                                                          .currentState!
                                                          .validate()) {
                                                        controller
                                                            .storeAdvertisement();
                                                      }
                                                    }),
                                            const SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                        ),
                ))));
  }
}
