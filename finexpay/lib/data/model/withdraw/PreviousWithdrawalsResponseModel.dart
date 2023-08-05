import '../auth/registration_response_model.dart';

class PreviousWithdrawalsResponseModel {
  PreviousWithdrawalsResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  PreviousWithdrawalsResponseModel.fromJson(dynamic json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    return map;
  }

}

class MainData {

  MainData({
      PastWithdrawals? pastWithdrawals,
    String? assetPath
  }){
    _pastWithdrawals = pastWithdrawals;
    _assetPath = assetPath;
}

  MainData.fromJson(dynamic json) {
    _pastWithdrawals = json['past_withdrawals'] != null ? PastWithdrawals.fromJson(json['past_withdrawals']) : null;
    _assetPath = json['crypto_image_path'];
  }
  PastWithdrawals? _pastWithdrawals;
  String? _assetPath;

  PastWithdrawals? get pastWithdrawals => _pastWithdrawals;
  String? get assetPath => _assetPath;



}

class PastWithdrawals {
  PastWithdrawals({
      List<Data>? data,
      dynamic nextPageUrl,
      }){
    _data = data;
    _nextPageUrl = nextPageUrl;
}

  PastWithdrawals.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }

  List<Data>? _data;
  dynamic _nextPageUrl;

  List<Data>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    return map;
  }

}



class Data {
  Data({
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

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cryptoId = json['crypto_currency_id']!=null?json['crypto_currency_id'].toString():null;
    _walletAddress = json['wallet_address'];
    _userId = json['user_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():null;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['crypto_id'] = _cryptoId;
    map['wallet_address'] = _walletAddress;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['trx'] = _trx;
    map['payable'] = _payable;
    map['status'] = _status;
    map['admin_feedback'] = _adminFeedback;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    return map;
  }

}

class Crypto {
  Crypto({
      int? id, 
      String? name, 
      String? code, 
      String? symbol, 
      String? rate, 
      String? dcFixed, 
      String? dcPercent, 
      String? wcFixed, 
      String? wcPercent, 
      String? status, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _code = code;
    _symbol = symbol;
    _rate = rate;
    _dcFixed = dcFixed;
    _dcPercent = dcPercent;
    _wcFixed = wcFixed;
    _wcPercent = wcPercent;
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
    _dcFixed = json['deposit_charge_fixed']!=null?json['deposit_charge_fixed']:null;
    _dcPercent = json['deposit_charge_percent']!=null?json['deposit_charge_percent'].toString():null;
    _wcFixed = json['withdraw_charge_fixed']!=null? json['withdraw_charge_fixed'].toString():null;
    _wcPercent = json['withdraw_charge_percent']!=null? json['withdraw_charge_percent'].toString():null;
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
  String? _dcFixed;
  String? _dcPercent;
  String? _wcFixed;
  String? _wcPercent;
  String? _status;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get symbol => _symbol;
  String? get rate => _rate;
  String? get dcFixed => _dcFixed;
  String? get dcPercent => _dcPercent;
  String? get wcFixed => _wcFixed;
  String? get wcPercent => _wcPercent;
  String? get status => _status;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    
    map['symbol'] = _symbol;
    map['rate'] = _rate;
    map['deposit_charge_fixed'] = _dcFixed;
    map['deposit_charge_percent'] = _dcPercent;
    map['withdraw_charge_fixed'] = _wcFixed;
    map['withdraw_charge_percent'] = _wcPercent;
    map['status'] = _status;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
