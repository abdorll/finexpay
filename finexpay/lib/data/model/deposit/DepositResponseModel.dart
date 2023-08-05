import '../auth/registration_response_model.dart';


class DepositResponseModel {
  DepositResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainDepositModel? mainDepositModel,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainDepositModel = mainDepositModel;
}

  DepositResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status']!=null? json['status'].toString():null;
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainDepositModel = json['data'] != null ? MainDepositModel.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainDepositModel? _mainDepositModel;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainDepositModel? get mainDepositModel => _mainDepositModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_mainDepositModel != null) {
      map['data'] = _mainDepositModel?.toJson();
    }
    return map;
  }

}

class MainDepositModel {
  MainDepositModel({
      String? cryptoImagePath, 
      Deposits? deposits,
    List<Crypto>? cryptos,
  }){
    _cryptoImagePath = cryptoImagePath;
    _deposits = deposits;
    _cryptos = cryptos;
}

  MainDepositModel.fromJson(dynamic json) {
    _cryptoImagePath = json['crypto_image_path'];
    _deposits = json['deposits'] != null ? Deposits.fromJson(json['deposits']) : null;
    if (json['cryptos'] != null) {
      _cryptos = [];
      json['cryptos'].forEach((v) {
        _cryptos?.add(Crypto.fromJson(v));
      });
    }
  }
  String? _cryptoImagePath;
  Deposits? _deposits;
  List<Crypto>? _cryptos;

  String? get cryptoImagePath => _cryptoImagePath;
  Deposits? get deposits => _deposits;
  List<Crypto>? get cryptos => _cryptos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['crypto_image_path'] = _cryptoImagePath;
    if (_deposits != null) {
      map['deposits'] = _deposits?.toJson();
    }
    return map;
  }

}

class Deposits {
  Deposits({
       
      List<DepositModel>? data,
      String? nextPageUrl, 
      }){
   
    _data = data;
    _nextPageUrl = nextPageUrl;
    
    
}

  Deposits.fromJson(dynamic json) {
    
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DepositModel.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    
    
  }
  
  List<DepositModel>? _data;
  String? _nextPageUrl;

  List<DepositModel>? get data => _data;
  String? get nextPageUrl => _nextPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    return map;
  }

}

class DepositModel {
  DepositModel({
      int? id, 
      String? userId, 
      String? cryptoId, 
      String? walletAddress, 
      String? amount, 
      String? charge, 
      String? finalAmo, 
      String? trx, 
      String? status, 
      dynamic cpTrx, 
      String? createdAt, 
      String? updatedAt, 
      Crypto? crypto,}){
    _id = id;
    _userId = userId;
    _cryptoId = cryptoId;
    _walletAddress = walletAddress;
    _amount = amount;
    _charge = charge;
    _finalAmo = finalAmo;
    _trx = trx;
    _status = status;
    _cpTrx = cpTrx;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _crypto = crypto;
}

  DepositModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _walletAddress = json['wallet_address'];
    _amount = json['amount']!=null?json['amount'].toString():null;;
    _charge = json['charge']!=null?json['charge'].toString():null;
    _finalAmo = json['final_amo'];
    _trx = json['trx'];
    _status = json['status']!=null? json['status'].toString():null;
    _cpTrx = json['cp_trx'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
  }
  int? _id;
  String? _userId;
  String? _cryptoId;
  String? _walletAddress;
  String? _amount;
  String? _charge;
  String? _finalAmo;
  String? _trx;
  String? _status;
  dynamic _cpTrx;
  String? _createdAt;
  String? _updatedAt;
  Crypto? _crypto;

  int? get id => _id;
  String? get userId => _userId;
  String? get cryptoId => _cryptoId;
  String? get walletAddress => _walletAddress;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get finalAmo => _finalAmo;
  String? get trx => _trx;
  String? get status => _status;
  dynamic get cpTrx => _cpTrx;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Crypto? get crypto => _crypto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['crypto_id'] = _cryptoId;
    map['wallet_address'] = _walletAddress;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['final_amo'] = _finalAmo;
    map['trx'] = _trx;
    map['status'] = _status;
    map['cp_trx'] = _cpTrx;
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

