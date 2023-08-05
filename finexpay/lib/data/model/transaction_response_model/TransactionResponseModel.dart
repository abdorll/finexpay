import '../auth/registration_response_model.dart';

class TransactionResponseModel {
  TransactionResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  TransactionResponseModel.fromJson(dynamic json) {
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
      Transactions? transactions,
    String?assetPath,
      List<Remarks>? remarks,}){
    _transactions = transactions;
    _assetPath=assetPath;
    _remarks = remarks;
}

  MainData.fromJson(dynamic json) {

    _transactions = json['transactions'] != null ? Transactions.fromJson(json['transactions']) : null;
    _assetPath = json['crypto_image_path'] ;
    if (json['remarks'] != null) {
      _remarks = [];
      json['remarks'].forEach((v) {
        _remarks?.add(Remarks.fromJson(v));
      });
    }
  }
  Transactions? _transactions;
  List<Remarks>? _remarks;
  String? _assetPath;

  Transactions? get transactions => _transactions;
  List<Remarks>? get remarks => _remarks;
  String? get assetPath => _assetPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactions != null) {
      map['transactions'] = _transactions?.toJson();
    }
    if(_assetPath!=null){
      map['"crypto_image_path']=_assetPath;
    }
    if (_remarks != null) {
      map['remarks'] = _remarks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Remarks {
  Remarks({
      String? remark,}){
    _remark = remark;
}

  Remarks.fromJson(dynamic json) {
    _remark = json['remark'];
  }
  String? _remark;

  String? get remark => _remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    return map;
  }

}

class Transactions {
  Transactions({
       
      List<Data>? data, 
      
       
      List<Links>? links, 
      String? nextPageUrl,
      }){
   
    _data = data;
    
    
    _links = links;
    _nextPageUrl = nextPageUrl;
    
    
}

  Transactions.fromJson(dynamic json) {
    
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    
    
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    
    
  }
  
  List<Data>? _data;
  
  
  List<Links>? _links;
  String? _nextPageUrl;
  
  

  
  List<Data>? get data => _data;
  
  
  List<Links>? get links => _links;
  String? get nextPageUrl => _nextPageUrl;
  
  
  
  

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    
    
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
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
      String? cryptoId, 
      String? userId, 
      String? amount, 
      String? charge, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt, 
      Crypto? crypto,}){
    _id = id;
    _cryptoId = cryptoId;
    _userId = userId;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _crypto = crypto;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cryptoId = json['crypto_currency_id'].toString();
    _userId = json['user_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():null;;
    _charge = json['charge']!=null?json['charge'].toString():null;
    _postBalance = json['post_balance'];
    _trxType = json['trx_type'];
    _trx = json['trx'];
    _details = json['details'];
    _remark = json['remark'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
  }
  int? _id;
  String? _cryptoId;
  String? _userId;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;
  Crypto? _crypto;

  int? get id => _id;
  String? get cryptoId => _cryptoId;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Crypto? get crypto => _crypto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['crypto_id'] = _cryptoId;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
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
