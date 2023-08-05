

import '../auth/registration_response_model.dart';

class PaymentMethodResponseModel {
  PaymentMethodResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  PaymentMethodResponseModel.fromJson(dynamic json) {
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
      List<FiatGateways>? fiatGateways,}){
    _fiatGateways = fiatGateways;
}

  Data.fromJson(dynamic json) {
    if (json['fiat_gateways'] != null) {
      _fiatGateways = [];
      json['fiat_gateways'].forEach((v) {
        _fiatGateways?.add(FiatGateways.fromJson(v));
      });
    }
  }
  List<FiatGateways>? _fiatGateways;

  List<FiatGateways>? get fiatGateways => _fiatGateways;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
      
      String? image, 
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
  
  String? _image;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  List<Fiat>? _fiat;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  
  String? get image => _image;
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
      String? code,}){
    _id = id;
    _code = code;
    
}

  Fiat.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
  }
  int? _id;
  String? _code;

  int? get id => _id;
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    
    return map;
  }

}
