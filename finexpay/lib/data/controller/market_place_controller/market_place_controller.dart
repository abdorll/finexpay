import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_coin/data/model/market_place/MarketPlaceResponseModel.dart'
    as market_model;
import 'package:local_coin/data/repo/marketplace_repo/market_place_repo.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/crypto_currency_response_model/CryptoCurrencyResponseModel.dart';
import '../../model/global/response_model/response_model.dart';

class MarketPlaceController extends GetxController {
  MarketplaceRepo repo;

  MarketPlaceController({required this.repo});

  bool isBuy = true;
  List<Cryptos> cryptoCurrencyList = [];
  List<market_model.Ads> advertisementList = [];
  bool isLoading = true;
  String serverType='';

  List<String> typeList = ['Buy', 'Sell'];
  String selectedType = 'Buy';
  String? imagePath = '';

  int cryptoId = -1;
  String selectedCrypto = '';



  Future<void> initData() async {
    page=0;
    await loadAllCryptoCurrencies();

  }


  int page=0;
  bool trxLoading=false;
  String? nextPageUrl;
  Future<void> loadTransaction() async {

    page=page+1;
    if(page==1){
      advertisementList.clear();
      trxLoading=true;
      update();
    }

    getIndexOfCryptoCurrency();

    final ResponseModel response = await repo.getAdvertisement(cryptoId,
        type: selectedType.toLowerCase().toString() == 'buy' ? '1' : '2',page: page);
    if (response.statusCode == 200) {



      market_model.MarketPlaceResponseModel model =
      market_model.MarketPlaceResponseModel.fromJson(
          jsonDecode(response.responseJson));

      serverType = model.data?.type??'';

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<market_model.Ads>? tempList = model.data?.ads;
        nextPageUrl=model.data?.nextPageUrl;
        if (tempList != null && tempList.isNotEmpty) {
          imagePath = model.data?.gatewayImagePath.toString();
          advertisementList.addAll(tempList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }

    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);

    }
    if(page==1){
      trxLoading=false;
    }
    update();
    return;
  }


  Future<void> loadAllCryptoCurrencies() async {
    isLoading=true;
    update();
    final ResponseModel response = await repo.getAllCryptoCurrencyList();

    if (response.statusCode == 200) {
      CryptoCurrencyResponseModel model = CryptoCurrencyResponseModel.fromJson(
          jsonDecode(response.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Cryptos>? tempList = model.data?.cryptos;
        if (tempList != null && tempList.isNotEmpty) {
          cryptoCurrencyList.clear();
          cryptoCurrencyList.addAll(tempList);
          selectedCrypto = cryptoCurrencyList[0].code.toString();
        filterData();
          // changeSelectedCrypto(cryptoCurrencyList[0].code??'');
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
            msg: [],
            isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [response.message], msg: [], isError: true);
    }
    isLoading=false;
    update();
  }


  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty? true: false ;
  }

  int getIndexOfCryptoCurrency() {
    int index = cryptoCurrencyList
        .indexWhere((element) => element.code == selectedCrypto);
    cryptoId = cryptoCurrencyList[index].id?.toInt() ?? -1;
    return index;
  }


  void filterData() async {
    page=0;
    advertisementList.clear();
    getIndexOfCryptoCurrency();
    loadTransaction();
    update();
  }

  changeCurrency(String value) {
    selectedCrypto = value;
    filterData();
  }

  void changeType(value) {
    selectedType = value;
    filterData();
    update();
  }
}
