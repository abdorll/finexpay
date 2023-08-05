
import '../../auth/registration_response_model.dart';

class SingleWalletAddressResponseModel {
  SingleWalletAddressResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData =mainData;
}

  SingleWalletAddressResponseModel.fromJson(dynamic json) {
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
  MainData? get mainData => _mainData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_mainData != null) {
      map['data'] = _mainData?.toJson();
    }
    return map;
  }

}

class MainData {
  MainData({
      String? totalAddressCount,
      CryptoWalletAddresses? cryptoWalletAddresses, 
      Crypto? crypto, 
      String? cryptoImagePath,}){
    _totalAddressCount = totalAddressCount;
    _cryptoWalletAddresses = cryptoWalletAddresses;
    _crypto = crypto;
    _cryptoImagePath = cryptoImagePath;
}

  MainData.fromJson(dynamic json) {
    _totalAddressCount = json['total_address_count']!=null?json['total_address_count'].toString():null;
    _cryptoWalletAddresses = json['crypto_wallet_addresses'] != null ? CryptoWalletAddresses.fromJson(json['crypto_wallet_addresses']) : null;
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _cryptoImagePath = json['crypto_image_path'];
  }
  String? _totalAddressCount;
  CryptoWalletAddresses? _cryptoWalletAddresses;
  Crypto? _crypto;
  String? _cryptoImagePath;

  String? get totalAddressCount => _totalAddressCount;
  CryptoWalletAddresses? get cryptoWalletAddresses => _cryptoWalletAddresses;
  Crypto? get crypto => _crypto;
  String? get cryptoImagePath => _cryptoImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_address_count'] = _totalAddressCount;
    if (_cryptoWalletAddresses != null) {
      map['crypto_wallet_addresses'] = _cryptoWalletAddresses?.toJson();
    }
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    map['crypto_image_path'] = _cryptoImagePath;
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

class CryptoWalletAddresses {
  CryptoWalletAddresses({
       
      List<Data>? data, 
     
      String? lastPageUrl,
      String? nextPageUrl,
      }){
    _data = data;
    _nextPageUrl = nextPageUrl;

}

  CryptoWalletAddresses.fromJson(dynamic json) {

    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }

    _nextPageUrl = json['next_page_url'];
  }

  List<Data>? _data;
  String? _nextPageUrl;



  List<Data>? get data => _data;
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

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class Data {
  Data({
      int? id, 
      String? userId, 
      String? cryptoId, 
      String? walletAddress, 
      String? createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _userId = userId;
    _cryptoId = cryptoId;
    _walletAddress = walletAddress;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _walletAddress = json['wallet_address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _cryptoId;
  String? _walletAddress;
  String? _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get cryptoId => _cryptoId;
  String? get walletAddress => _walletAddress;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['crypto_id'] = _cryptoId;
    map['wallet_address'] = _walletAddress;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

