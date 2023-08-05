


import '../auth/registration_response_model.dart';

class FilterResponseModel {
  FilterResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  FilterResponseModel.fromJson(dynamic json) {
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
      List<Cryptos>? cryptos, 
      List<FiatGateways>? fiatGateways,}){
    _cryptos = cryptos;
    _fiatGateways = fiatGateways;
}

  Data.fromJson(dynamic json) {
    if (json['cryptos'] != null) {
      _cryptos = [];
      json['cryptos'].forEach((v) {
        _cryptos?.add(Cryptos.fromJson(v));
      });
    }
    if (json['fiat_gateways'] != null) {
      _fiatGateways = [];
      json['fiat_gateways'].forEach((v) {
        _fiatGateways?.add(FiatGateways.fromJson(v));
      });
    }
  }
  List<Cryptos>? _cryptos;
  List<FiatGateways>? _fiatGateways;

  List<Cryptos>? get cryptos => _cryptos;
  List<FiatGateways>? get fiatGateways => _fiatGateways;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cryptos != null) {
      map['cryptos'] = _cryptos?.map((v) => v.toJson()).toList();
    }
    if (_fiatGateways != null) {
      map['fiat_gateways'] = _fiatGateways?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FiatGateways {
  FiatGateways({
      int? id, 
      String? name, 
      String? slug,
      dynamic image, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      List<Fiat>? fiat,}){
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fiat = fiat;
}

  FiatGateways.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _image = json['image'];
    _status = json['status']!=null? json['status'].toString():null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['fiat'] != null) {
      _fiat = [];
      json['fiat'].forEach((v) {
        _fiat?.add(Fiat.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _slug;
  
  dynamic _image;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  List<Fiat>? _fiat;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  
  dynamic get image => _image;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Fiat>? get fiat => _fiat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_fiat != null) {
      map['fiat'] = _fiat?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Fiat {
  Fiat({
      int? id, 
      String? code, 
      String? name, 
      String? symbol, 
      String? rate, 
      String? status,}){
    _id = id;
    _code = code;
    _name = name;
    _symbol = symbol;
    _rate = rate;
    _status = status;
}

  Fiat.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _name = json['name'];
    _symbol = json['symbol'];
   _rate = json['rate']!=null?json['rate'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
  }
  int? _id;
  String? _code;
  String? _name;
  String? _symbol;
  String? _rate;
  String? _status;

  int? get id => _id;
  String? get code => _code;
  String? get name => _name;
  String? get symbol => _symbol;
  String? get rate => _rate;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    
    map['name'] = _name;
    map['symbol'] = _symbol;
    map['rate'] = _rate;
    map['status'] = _status;
    return map;
  }

}

class Cryptos {
  Cryptos({
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

  Cryptos.fromJson(dynamic json) {
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

