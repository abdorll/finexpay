import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/data/repo/advertisement_repo/advertisement_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/authorization/AuthorizationResponseModel.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/new_advertisement/NewAdvertisementResponseModel.dart';
import '../../model/new_advertisement/new_advertisement_body_model.dart';

class EditAdvertisementController extends GetxController{

  AdvertisementRepo repo;
  EditAdvertisementController({required this.repo});

  bool isLimit =false;
  String limitMessage='';
  int advertisementId=-1;

  TextEditingController priceTypeController = TextEditingController();
  TextEditingController paymentDetailsController = TextEditingController();
  TextEditingController termsOfTradeController = TextEditingController();
  TextEditingController marginController = TextEditingController();
  TextEditingController minimumController = TextEditingController();
  TextEditingController maximumController = TextEditingController();

  String selectedPriceType = MyStrings.margin;
  String price = '0.00';
  String selectedTrxType = MyStrings.buy;
  List<String> trxTypeList = [MyStrings.buy, MyStrings.sell];
  List<String> priceTypeList = [MyStrings.margin, MyStrings.fixed];

  Cryptos selectedCryptoCurrency = Cryptos();
  FiatGateways selectedPaymentMethod = FiatGateways();
  Fiat selectedFiatCurrency = Fiat();
  PaymentWindows selectedPaymentWindow = PaymentWindows();

  List<Cryptos> cryptoCurrencyList = [];
  List<PaymentWindows> paymentWindowList = [];
  List<FiatGateways> paymentMethodList = [];
  List<Fiat> fiatCurrencyList = [];
  Ad? ad;

  bool isBuy = true;
  bool isLoading = true;

  initData() async {
    isLoading = true;
    update();

    ResponseModel response = await repo.getEditAdvertisementData(advertisementId);

    if (response.statusCode == 200) {
      NewAdvertisementResponseModel model =
      NewAdvertisementResponseModel.fromJson(
          jsonDecode(response.responseJson));
      if(model.remark?.toLowerCase()==MyStrings.adLimitRemarks.toLowerCase()){
        isLimit=true;
        limitMessage=model.message?.error?.toString()??MyStrings.youHaveReachedMaxLimitMsg;
        update();
        return;
      }
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        cryptoCurrencyList.clear();
        ad=model.data?.ad;
        List<Cryptos>? tempCryptoList = model.data?.cryptos;
        List<PaymentWindows>? tempPaymentWindowList =
            model.data?.paymentWindows;
        List<FiatGateways>? tempPaymentMethodList = model.data?.fiatGateways;

        if (tempCryptoList != null && tempCryptoList.isNotEmpty) {
          cryptoCurrencyList.addAll(tempCryptoList);
        }

        if (tempPaymentMethodList != null && tempPaymentMethodList.isNotEmpty) {
          paymentMethodList.addAll(tempPaymentMethodList);
          List<Fiat>? tempFiatList = paymentMethodList[0].fiat;
          if (tempFiatList != null && tempFiatList.isNotEmpty) {
            fiatCurrencyList.addAll(tempFiatList);
          }
        }

        if (tempPaymentWindowList != null && tempPaymentWindowList.isNotEmpty) {
          paymentWindowList.addAll(tempPaymentWindowList);
        }

        selectInitialListData();

      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [''], msg: [], isError: true);
        isLoading = false;
        update();
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
  }

  void selectInitialListData() {
    if (cryptoCurrencyList.isNotEmpty) {
      for (var element in cryptoCurrencyList) {
        if(element.id.toString()==ad?.cryptoCurrencyId.toString()){
          selectedCryptoCurrency=element;
          break;
        }
      }
    }
    if (paymentMethodList.isNotEmpty) {
      selectedPaymentMethod = paymentMethodList.where((element) => element.id.toString()==ad?.fiatGatewayId.toString()).toList()[0]  ;
      fiatCurrencyList.insert(
          0,
          Fiat(
              id: -1,
              name: MyStrings.selectOne,
              code: MyStrings.selectOne,
              symbol: "",
              rate: "0",
              status: '',
              createdAt: '',
              updatedAt: ''));
      if (selectedPaymentMethod.fiat != null &&
          selectedPaymentMethod.fiat!.isNotEmpty) {
        fiatCurrencyList.addAll(selectedPaymentMethod.fiat!);
        selectedFiatCurrency = fiatCurrencyList.where((element) => element.id.toString()==ad?.fiatCurrencyId.toString()).toList()[0] ;
      }
    }
    if (paymentWindowList.isNotEmpty) {
      selectedPaymentWindow = paymentWindowList.where((element) => element.minute.toString()==ad?.window.toString()).toList()[0] ;
    }

    paymentDetailsController.text=ad?.details??'';
    termsOfTradeController.text=ad?.terms??'';
    minimumController.text=CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(ad?.min??'0');
    maximumController.text=CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(ad?.max??'0');
    int typeIndex=ad?.type.toString()=='1'?0:1;
    selectedTrxType=trxTypeList[typeIndex];

    // if fixed price greater then zero then price type is fixed else price type is margin

    double tempFixedPrice=double.tryParse(ad?.fixedPrice??'0')??0;
    if(tempFixedPrice>0){
      selectedPriceType=priceTypeList[1];
      marginController.text = CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(ad?.fixedPrice.toString()??'0');
      marginOrFixedChange(marginController.text);
    }else{
      selectedPriceType=priceTypeList[0];
      marginController.text = CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(ad?.margin.toString()??'0');
      marginOrFixedChange(marginController.text);
    }

    isLoading = false;
    update();
  }

  changeTrxType(int index) {
    selectedTrxType = trxTypeList[index];
    changeFilterData();
  }

  changePriceType(int index) {
    selectedPriceType = priceTypeList[index];
    update();
    changeFilterData();
  }

  changePaymentWindow(int index) {
    selectedPaymentWindow = paymentWindowList[index];
    update();
    changeFilterData();
  }

  void changeCrypto(int index) {
    selectedCryptoCurrency = cryptoCurrencyList[index];
    changeFilterData();
  }

  changePaymentMethod(int index) {
    selectedPaymentMethod = paymentMethodList[index];
    fiatCurrencyList.clear();
    fiatCurrencyList.insert(
        0,
        Fiat(
            id: -1,
            name: MyStrings.selectOne,
            code: '',
            symbol: '',
            rate: '0',
            status: '',
            createdAt: '',
            updatedAt: ''));

    if (selectedPaymentMethod.fiat != null &&
        selectedPaymentMethod.fiat!.isNotEmpty) {
      fiatCurrencyList.addAll(selectedPaymentMethod.fiat!);
      selectedFiatCurrency = fiatCurrencyList[0];
    }

    changeFilterData();
  }

  changeFiatCurrency(int index) {
    selectedFiatCurrency = fiatCurrencyList[index];
    changeFilterData();
  }

  double fixedOrMarginValue = 0;

  void marginOrFixedChange(String v) {
    double value = double.tryParse(v.toString()) ?? 0.0;
    fixedOrMarginValue = value;
    calculatePrice();
  }

  changeFilterData() {
    calculatePrice();
  }

  String priceCurrency = '';

  void calculatePrice() {
    priceCurrency =
    '${selectedFiatCurrency.code}/${selectedCryptoCurrency.code}';
    if (selectedPriceType.toLowerCase() == 'fixed') {
      price = '$fixedOrMarginValue';
      update();
    } else {
      double cryptoRate =
          double.tryParse(selectedCryptoCurrency.rate ?? '') ?? 0;
      double fiatRate = double.tryParse(selectedFiatCurrency.rate ?? '') ?? 0;
      double amount = cryptoRate * fiatRate;
      if (selectedTrxType.toString().toLowerCase() == 'buy') {
        price =
            (amount - ((amount * fixedOrMarginValue) / 100)).toStringAsFixed(8);
        update();
      } else {
        price =
            (amount + ((amount * fixedOrMarginValue) / 100)).toStringAsFixed(8);
        update();
      }
    }
  }


  bool storeLoading=false;
  void updateAdvertisement() async {

    storeLoading=true;
    update();
    NewAdvertisementBodyModel bodyModel=NewAdvertisementBodyModel(trxType: selectedTrxType.toLowerCase()=='buy'?'1':'2', cryptoId: selectedCryptoCurrency.id.toString(), fiatGatewayId: selectedPaymentMethod.id.toString(), fiatId: selectedFiatCurrency.id.toString(),
        window:selectedPaymentWindow.minute.toString(), min: minimumController.text.toString(), max: maximumController.text.toString(), details: paymentDetailsController.text.toString(),
        terms: termsOfTradeController.text.toString(),priceType:selectedPriceType.toLowerCase()=="margin"?'1':'2',margin: selectedPriceType.toLowerCase()=='margin'?marginController.text.toString():'-1',fixedPrice: selectedPriceType.toLowerCase()=='margin'?'-1':marginController.text.toString() );

    ResponseModel response = await repo.updateAdvertisement(bodyModel.toJson(),advertisementId);

    if(response.statusCode==200){

      AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackbar.showCustomSnackbar(errorList: [], msg:[ model.message?.success.toString()??MyStrings.somethingWentWrong], isError:false);
      }else{
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??[MyStrings.somethingWentWrong], msg: [], isError: true);
      }
      storeLoading=false;
      update();

    }
    else{

      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      storeLoading=false;
      update();

    }

  }

}