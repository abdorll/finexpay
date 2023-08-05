import '../../auth/registration_response_model.dart';

class MainWalletResponseModel {
  MainWalletResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  MainWalletResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status']!=null? json['status'].toString():null;
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    List<Wallets>? wallets,
    String? cryptoImagePath,}){
    _wallets = wallets;
    _cryptoImagePath = cryptoImagePath;
  }

  Data.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      _wallets = [];
      json['wallets'].forEach((v) {
        _wallets?.add(Wallets.fromJson(v));
      });
    }
    _cryptoImagePath = json['crypto_image_path'];
  }
  List<Wallets>? _wallets;
  String? _cryptoImagePath;

  List<Wallets>? get wallets => _wallets;
  String? get cryptoImagePath => _cryptoImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_wallets != null) {
      map['wallets'] = _wallets?.map((v) => v.toJson()).toList();
    }
    map['crypto_image_path'] = _cryptoImagePath;
    return map;
  }

}

class Wallets {
  Wallets({
      int? id, 
      String? userId, 
      String? cryptoId, 
      String? balance, 
      dynamic createdAt, 
      String? updatedAt, 
      Crypto? crypto,}){
    _id = id;
    _userId = userId;
    _cryptoId = cryptoId;
    _balance = balance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _crypto = crypto;
}

  Wallets.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id']!=null?json['user_id'].toString():null;;
    _cryptoId = json['crypto_currency_id']!=null?json['crypto_currency_id'].toString():null;
    _balance = json['balance']!=null?json['balance'].toString():null;;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
  }
  int? _id;
  String? _userId;
  String? _cryptoId;
  String? _balance;
  dynamic _createdAt;
  String? _updatedAt;
  Crypto? _crypto;

  int? get id => _id;
  String? get userId => _userId;
  String? get cryptoId => _cryptoId;
  String? get balance => _balance;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Crypto? get crypto => _crypto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['crypto_currency_id'] = _cryptoId;
    map['balance'] = _balance;
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
    _dcFixed =json['deposit_charge_fixed']!=null?json['deposit_charge_fixed'].toString():null;
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
