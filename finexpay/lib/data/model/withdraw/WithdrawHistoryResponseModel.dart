import '../auth/registration_response_model.dart';

class WithdrawHistoryResponseModel {
  WithdrawHistoryResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  WithdrawHistoryResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status']!=null? json['status'].toString():null;
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainData = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _mainData;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _mainData;


}

class MainData {
  MainData({
    String? cryptoImagePath,
    Withdrawals? withdrawals,
    List<Crypto>? crypto,}){
    _cryptoImagePath = cryptoImagePath;
    _withdrawals = withdrawals;
    _crypto = crypto;
}

  MainData.fromJson(dynamic json) {
    _cryptoImagePath = json['crypto_image_path'];
    _withdrawals = json['withdrawals'] != null ? Withdrawals.fromJson(json['withdrawals']) : null;
    if (json['cryptos'] != null) {
      _crypto = [];
      json['cryptos'].forEach((v) {
        _crypto?.add(Crypto.fromJson(v));
      });
    }
  }
  Withdrawals? _withdrawals;
  String? _cryptoImagePath;
  List<Crypto>? _crypto;

  String? get cryptoImagePath => _cryptoImagePath;
  Withdrawals? get withdrawals => _withdrawals;
  List<Crypto>? get cryptos => _crypto;


}

class Withdrawals {
  Withdrawals({
       
     List<WithdrawModel>? data,
      String? nextPageUrl, 
      }){
   
    _data = data;
    _nextPageUrl = nextPageUrl;
    
    
}

  Withdrawals.fromJson(dynamic json) {
    
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WithdrawModel.fromJson(v));
      });
    }

    _nextPageUrl = json['next_page_url'];
    
    
  }
  
  List<WithdrawModel>? _data;
  String? _nextPageUrl;
  List<WithdrawModel>? get data => _data;

  String? get nextPageUrl => _nextPageUrl;



}

class WithdrawModel {
 WithdrawModel({
      int? id, 
      String? cryptoId, 
      String? walletAddress, 
      String? userId, 
      String? amount, 
      String? charge, 
      String? trx, 
      String? payable, 
      String? status, 
      dynamic adminFeedback, 
      String? createdAt, 
      String? updatedAt, 
      Crypto? crypto,}){
    _id = id;
    _cryptoId = cryptoId;
    _walletAddress = walletAddress;
    _userId = userId;
    _amount = amount;
    _charge = charge;
    _trx = trx;
    _payable = payable;
    _status = status;
    _adminFeedback = adminFeedback;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _crypto = crypto;
}

 WithdrawModel.fromJson(dynamic json) {
    _id = json['id'];
    _cryptoId = json['crypto_currency_id'].toString();
    _walletAddress = json['wallet_address'];
    _userId = json['user_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():null;;
    _charge = json['charge']!=null?json['charge'].toString():null;
    _trx = json['trx'];
    _payable = json['payable']!=null?json['payable'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _adminFeedback = json['admin_feedback'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
  }
  int? _id;
  String? _cryptoId;
  String? _walletAddress;
  String? _userId;
  String? _amount;
  String? _charge;
  String? _trx;
  String? _payable;
  String? _status;
  dynamic _adminFeedback;
  String? _createdAt;
  String? _updatedAt;
  Crypto? _crypto;

  int? get id => _id;
  String? get cryptoId => _cryptoId;
  String? get walletAddress => _walletAddress;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get trx => _trx;
  String? get payable => _payable;
  String? get status => _status;
  dynamic get adminFeedback => _adminFeedback;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Crypto? get crypto => _crypto;


}

class Crypto {
  Crypto({
      int? id, 
      String? name, 
      String? code, 
      String? symbol, 
      String? rate,
      String? depositChargeFixed,
      String? depositChargePercent,
      String? withdrawChargeFixed,
      String? withdrawChargePercent,
      String? status, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _code = code;
    _symbol = symbol;
    _rate = rate;
    _depositChargeFixed = depositChargeFixed;
    _depositChargePercent = depositChargePercent;
    _withdrawChargeFixed = withdrawChargeFixed;
    _withdrawChargePercent = withdrawChargePercent;
    _status = status;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Crypto.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _symbol = json['symbol'];
   _rate = json['rate']!=null?json['rate'].toString():null;
   _depositChargeFixed = json['deposit_charge_fixed']!=null?json['deposit_charge_fixed']:null;
   _depositChargePercent = json['deposit_charge_percent']!=null?json['deposit_charge_percent'].toString():null;
    _withdrawChargeFixed = json['withdraw_charge_fixed']!=null? json['withdraw_charge_fixed'].toString():null;
    _withdrawChargePercent = json['withdraw_charge_percent']!=null? json['withdraw_charge_percent'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _code;
  String? _symbol;
  String? _rate;
  String? _depositChargeFixed;
  String? _depositChargePercent;
  String? _withdrawChargeFixed;
  String? _withdrawChargePercent;
  String? _status;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get symbol => _symbol;
  String? get rate => _rate;
  String? get depositChargeFixed => _depositChargeFixed;
  String? get depositChargePercent => _depositChargePercent;
  String? get withdrawChargeFixed => _withdrawChargeFixed;
  String? get withdrawChargePercent => _withdrawChargePercent;
  String? get status => _status;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;



}
