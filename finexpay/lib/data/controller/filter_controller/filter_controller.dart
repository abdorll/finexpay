import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_coin/data/model/advertisement/FilterResponseModel.dart';
import 'package:local_coin/data/repo/filter/filter_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../core/route/route.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/country_model/CountryModel.dart';
import '../../model/global/response_model/response_model.dart';

class FilterController extends GetxController {
  FilterRepo repo;

  FilterController({required this.repo});

  bool isLoading = true;
  String selectedCrypto = '';
  String selectedPaymentMethod = '';
  String selectedFiatCurrency = '';
  String selectedCountry = MyStrings.selectOne;
  String selectedTrxType = MyStrings.buy;
  List<String> trxTypeList = [MyStrings.buy, MyStrings.sell];
  TextEditingController amountController = TextEditingController();
  List<Cryptos> cryptoCurrencyList = [];
  List<FiatGateways> paymentMethodList = [];
  List<Countries> countryList = [];
  List<Fiat> fiatList = [Fiat(id: -1, code: MyStrings.selectOne)];

  int paymentMethodId = -1;
  String selectedCountryCode = '-1';
  int fiatId = -1;
  int cryptoId = -1;
  final String selectOne = MyStrings.selectOne;

  bool noInternet = false;
  void changeNoInternetStatus(bool status) {
    noInternet = status;
    update();
  }

  initData() async {
    isLoading = true;
    update();

    countryList.clear();
    paymentMethodList.clear();
    cryptoCurrencyList.clear();
    fiatList.clear();
    fiatList = [Fiat(id: -1, code: MyStrings.selectOne)];

    countryList.insert(
        0, Countries(country: selectOne, countryCode: '-1', dialCode: '-1'));
    selectedCountry = countryList[0].country.toString();

    paymentMethodList.insert(
        0,
        FiatGateways(
            id: -1,
            name: selectOne,
            slug: '',
            image: '',
            status: '',
            createdAt: '',
            updatedAt: ''));
    changePaymentMethod(selectOne);
    await loadData();

    isLoading = false;
    update();
  }

  Future<void> loadData() async {
    ResponseModel response = await repo.getAdFilterData();
    if (response.statusCode == 200) {
      FilterResponseModel model =
          FilterResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        loadOfferLocation(response.responseJson);
        List<FiatGateways>? temp = model.data?.fiatGateways;
        List<Cryptos>? tempCrypto = model.data?.cryptos;

        loadPaymentMethod(temp);
        loadAllCryptoCurrencies(tempCrypto);
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
    } else {
      if (response.statusCode == 503) {
        changeNoInternetStatus(true);
      }
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
    return;
  }

  void loadAllCryptoCurrencies(List<Cryptos>? tempList) async {
    if (tempList != null && tempList.isNotEmpty) {
      cryptoCurrencyList.clear();
      cryptoCurrencyList.addAll(tempList);
      selectedCrypto = cryptoCurrencyList[0].code.toString();
    }
    return;
  }

  void loadPaymentMethod(List<FiatGateways>? tempList) async {
    if (tempList != null && tempList.isNotEmpty) {
      paymentMethodList.clear();
      paymentMethodList.addAll(tempList);
    }
    return;
  }

  void loadOfferLocation(String data) async {
    var json = jsonDecode(data);

    var countryMap = json['data']['countries'] as Map<String, dynamic>;
    countryMap.forEach((key, value) {
      var country = Countries(
          country: value['country'],
          dialCode: value['dial_code'],
          countryCode: key);
      countryList.add(country);
    });
  }

  changeTrxType(String value) {
    selectedTrxType = value;
    update();
  }

  changeCurrency(String value) {
    selectedCrypto = value;
    update();
  }

  void changePaymentMethod(String value) {
    selectedPaymentMethod = value;

    int index = paymentMethodList.indexWhere((element) => element.name?.toLowerCase() == selectedPaymentMethod.toLowerCase());
    paymentMethodId = paymentMethodList[index].id?.toInt() ?? -1;
    List<Fiat>? tempFiatList = paymentMethodList[index].fiat;

    if (tempFiatList != null && tempFiatList.isNotEmpty) {
      fiatList.clear();
      fiatList.addAll(tempFiatList);
      changeFiatCurrency(paymentMethodList[index].fiat?.first.code ?? '');
    } else {
      fiatList.clear();
      fiatList.insert(
          0,
          Fiat(
              id: -1,
              code: MyStrings.selectOne,
              name: MyStrings.selectOne,
              symbol: '',
              rate: '',
              status: ''));
      changeFiatCurrency(fiatList[0].code ?? MyStrings.selectOne);
    }
  }

  void changeOfferLocation(String value) {
    selectedCountry = value;
    int index = countryList.indexWhere((element) => element.country?.toLowerCase() == selectedCountry.toLowerCase());
    selectedCountryCode = countryList[index].countryCode ?? '-1';
    update();
  }

  void changeFiatCurrency(String value) {
    selectedFiatCurrency = value;

    int index = fiatList.indexWhere((element) =>
        element.code?.toLowerCase() == selectedFiatCurrency.toLowerCase());

    fiatId = fiatList[index].id ?? -1;
    update();
  }

  bool canGo() {

      initCryptoId();
      int trxType = selectedTrxType.toLowerCase() == 'buy' ? 1 : 2;
      String country = selectedCountry.toLowerCase() == selectOne.toLowerCase() ? 'all' : selectedCountry;
      String countryCode = selectedCountryCode == '-1' ? 'all' : selectedCountryCode;
      String amount = amountController.text.isEmpty ? '' : amountController.text.toString();
      Get.toNamed(RouteHelper.filterResultScreen, arguments: [
        trxType,
        cryptoId,
        country,
        countryCode,
        paymentMethodId,
        fiatId,
        amount
      ]);
      return true;

  }

  void initCryptoId() {
    int index = cryptoCurrencyList.indexWhere((element) => element.code == selectedCrypto);
    cryptoId = cryptoCurrencyList[index].id?.toInt() ?? -1;

    return;
  }
}
