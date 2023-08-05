import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/new_advertisement/NewAdvertisementResponseModel.dart';
import 'package:local_coin/data/model/new_advertisement/new_advertisement_body_model.dart';
import 'package:local_coin/data/repo/advertisement_repo/advertisement_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';


class NewAdvertisementController extends GetxController {
  AdvertisementRepo repo;
  bool isLimit =false;
  String limitMessage='';

  NewAdvertisementController({required this.repo});

  TextEditingController priceTypeController = TextEditingController();
  TextEditingController paymentDetailsController = TextEditingController();
  TextEditingController termsOfTradeController = TextEditingController();
  TextEditingController marginController = TextEditingController();
  TextEditingController minimumController = TextEditingController();
  TextEditingController maximumController = TextEditingController();

  String priceType = MyStrings.margin;
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

  bool isBuy = true;
  bool isLoading = true;

  initData() async {
    isLoading = true;
    update();

    ResponseModel response = await repo.getNewAdvertisementData();

    if (response.statusCode == 200) {
      NewAdvertisementResponseModel model =
          NewAdvertisementResponseModel.fromJson(
              jsonDecode(response.responseJson));
      if(model.remark=='ad_limit'){
        isLimit=true;
        limitMessage=model.message?.error?.toString()??MyStrings.youHaveReachedMaxLimitMsg;
        update();
        return;
      }
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        cryptoCurrencyList.clear();
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

        paymentWindowList.insert(0, PaymentWindows(id:-1,minute: 'Select One',createdAt: '',updatedAt: ''));
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
    }
    else {
      if (response.statusCode == 503) {
        changeNoInternetStatus(true);
      }
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
  }

  void selectInitialListData() {
    if (cryptoCurrencyList.isNotEmpty) {
      selectedCryptoCurrency = cryptoCurrencyList[0];
    }
    if (paymentMethodList.isNotEmpty) {
      selectedPaymentMethod = paymentMethodList[0];
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
        selectedFiatCurrency = fiatCurrencyList[0];
      }
    }

    if (paymentWindowList.isNotEmpty) {
      selectedPaymentWindow = paymentWindowList[0];
    }
    price = '0.0';

    isLoading = false;
    update();
  }

  changeTrxType(int index) {
    selectedTrxType = trxTypeList[index];
    changeFilterData();
  }

  changePriceType(int index) {
    priceType = priceTypeList[index];
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
            code: MyStrings.selectOne,
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
    update();
  }

  String priceCurrency = '';

  void calculatePrice() {
    priceCurrency =
        '${selectedFiatCurrency.code}/${selectedCryptoCurrency.code}';
    if (priceType.toLowerCase() == 'fixed') {
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


  bool hasError(){
    List<String>errorList=[];
    if (selectedFiatCurrency
        .id
        .toString() ==
        '-1') {
     errorList.add(MyStrings.selectAFiatCurrency);
    }
    if(selectedPaymentWindow.id.toString()=='-1'){
      errorList.add( errorList.isEmpty?MyStrings.selectAPaymentWindow:'\n${MyStrings.selectAPaymentWindow}');
    }

    if(errorList.isEmpty){
      return false;
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: errorList, msg: [], isError: true);
          return true;
    }
  }

  bool storeLoading=false;
  void storeAdvertisement() async {

   bool b= hasError();
   if(b){
     return;
   }

    storeLoading=true;
    update();
    NewAdvertisementBodyModel bodyModel=NewAdvertisementBodyModel(trxType: selectedTrxType.toLowerCase()=='buy'?'1':'2', cryptoId: selectedCryptoCurrency.id.toString(), fiatGatewayId: selectedPaymentMethod.id.toString(), fiatId: selectedFiatCurrency.id.toString(),
        window:selectedPaymentWindow.minute.toString(), min: minimumController.text.toString(), max: maximumController.text.toString(), details: paymentDetailsController.text.toString(),
        terms: termsOfTradeController.text.toString(),priceType:priceType.toLowerCase()=="margin"?'1':'2',margin: priceType.toLowerCase()=='margin'?marginController.text.toString():'-1',fixedPrice: priceType.toLowerCase()=='margin'?'-1':marginController.text.toString() );

    ResponseModel response = await repo.storeNewAdvertisement(bodyModel.toJson());
    
    if(response.statusCode==200){

      AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackbar.showCustomSnackbar(errorList: [], msg:[ model.message?.success.toString()??MyStrings.somethingWentWrong], isError:false);
        termsOfTradeController.text='';
        paymentDetailsController.text='';
        minimumController.text='';
        maximumController.text='';
        marginController.text='';
        price='0';
        changePaymentMethod(0);
        changeCrypto(0);
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

  bool noInternet = false;
  void changeNoInternetStatus(bool status) {
    noInternet = status;
    update();
  }


}
