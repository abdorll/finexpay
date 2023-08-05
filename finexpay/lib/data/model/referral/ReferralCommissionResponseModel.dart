import '../auth/registration_response_model.dart';

class ReferralCommissionResponseModel {
 ReferralCommissionResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

 ReferralCommissionResponseModel.fromJson(dynamic json) {
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
    if (_mainData != null) {
      map['data'] = _mainData?.toJson();
    }
    return map;
  }

}

class MainData {
  Data({
      ReferralLogs? referralLogs,
    String? cryptoImagePath,
  }){
    _referralLogs = referralLogs;
    _cryptoImagePath = cryptoImagePath;
}

  MainData.fromJson(dynamic json) {
    _referralLogs = json['referral_logs'] != null ? ReferralLogs.fromJson(json['referral_logs']) : null;
    _cryptoImagePath = json['crypto_image_path'];
  }
  ReferralLogs? _referralLogs;
  String? _cryptoImagePath;

  ReferralLogs? get referralLogs => _referralLogs;
  String? get cryptoImagePath => _cryptoImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_referralLogs != null) {
      map['referral_logs'] = _referralLogs?.toJson();
    }
    map['crypto_image_path'] = _cryptoImagePath;
    return map;
  }

}

class ReferralLogs {
  ReferralLogs({
       
      List<Data>? data, 
      
       
      List<Links>? links, 
      dynamic nextPageUrl, 
      }){
   
    _data = data;
    
    
    _links = links;
    _nextPageUrl = nextPageUrl;
    
    
}

  ReferralLogs.fromJson(dynamic json) {
    
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
  dynamic _nextPageUrl;
  
  

  
  List<Data>? get data => _data;
  
  
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  
  
  
  

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
      String? fromId, 
      String? toId, 
      String? cryptoId, 
      String? level, 
      String? commissionAmount, 
      String? postBalance, 
      String? trxAmo, 
      String? percent, 
      String? title, 
      String? type, 
      String? trx, 
      String? createdAt, 
      dynamic updatedAt, 
      ByWho? bywho, 
      Crypto? crypto,}){
    _id = id;
    _fromId = fromId;
    _toId = toId;
    _cryptoId = cryptoId;
    _level = level;
    _commissionAmount = commissionAmount;
    _postBalance = postBalance;
    _trxAmo = trxAmo;
    _percent = percent;
    _title = title;
    _type = type;
    _trx = trx;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _bywho = bywho;
    _crypto = crypto;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fromId = json['from_id'].toString();
    _toId = json['to_id'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _level = json['level'].toString();
    _commissionAmount = json['commission_amount'].toString();
    _postBalance = json['post_balance'].toString();
    _trxAmo = json['trx_amo'].toString();
    _percent = json['percent'].toString();
    _title = json['title'].toString();
    _type = json['type'].toString();
    _trx = json['trx'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _bywho = json['bywho'] != null ? ByWho.fromJson(json['bywho']) : null;
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
  }
  int? _id;
  String? _fromId;
  String? _toId;
  String? _cryptoId;
  String? _level;
  String? _commissionAmount;
  String? _postBalance;
  String? _trxAmo;
  String? _percent;
  String? _title;
  String? _type;
  String? _trx;
  String? _createdAt;
  dynamic _updatedAt;
  ByWho? _bywho;
  Crypto? _crypto;

  int? get id => _id;
  String? get fromId => _fromId;
  String? get toId => _toId;
  String? get cryptoId => _cryptoId;
  String? get level => _level;
  String? get commissionAmount => _commissionAmount;
  String? get postBalance => _postBalance;
  String? get trxAmo => _trxAmo;
  String? get percent => _percent;
  String? get title => _title;
  String? get type => _type;
  String? get trx => _trx;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  ByWho? get bywho => _bywho;
  Crypto? get crypto => _crypto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['from_id'] = _fromId;
    map['to_id'] = _toId;
    map['crypto_id'] = _cryptoId;
    map['level'] = _level;
    map['commission_amount'] = _commissionAmount;
    map['post_balance'] = _postBalance;
    map['trx_amo'] = _trxAmo;
    map['percent'] = _percent;
    map['title'] = _title;
    map['type'] = _type;
    map['trx'] = _trx;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_bywho != null) {
      map['bywho'] = _bywho?.toJson();
    }
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

class ByWho {
  ByWho({
      int? id, 
      String? firstname, 
      String? lastname, 
      String? username, 
      String? email, 
      String? countryCode, 
      String? mobile, 
      
      String? balance, 
      String? image, 
      Address? address, 
      String? status,
      String? kv, 
      String? ev, 
      String? sv, 
      String? regStep, 
      dynamic verCode, 
      dynamic verCodeSendAt, 
      String? ts, 
      String? tv, 
      String? tsc, 
      dynamic banReason, 
      String? completedTrade, 
      String? totalMin, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _kv = kv;
    _ev = ev;
    _sv = sv;
    _regStep = regStep;
  
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _banReason = banReason;
    _completedTrade = completedTrade;
    _totalMin = totalMin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  ByWho.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    
    _balance = json['balance'];
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status']!=null? json['status'].toString():null;

    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    
   
    _ts = json['ts'].toString();
    _tv =  json['tv'].toString();
    _tsc = json['tsc'].toString();
    
    _completedTrade = json['completed_trade'].toString();
   
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  String? _kv;
  String? _ev;
  String? _sv;
  String? _regStep;
  
  String? _ts;
  String? _tv;
  String? _tsc;
  dynamic _banReason;
  String? _completedTrade;
  String? _totalMin;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get sv => _sv;
  String? get regStep => _regStep;
  
  
  String? get ts => _ts;
  String? get tv => _tv;
  String? get tsc => _tsc;
  dynamic get banReason => _banReason;
  String? get completedTrade => _completedTrade;
  String? get totalMin => _totalMin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['reg_step'] = _regStep;
    
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['ban_reason'] = _banReason;
    map['completed_trade'] = _completedTrade;
    map['total_min'] = _totalMin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}



class Address {
  Address({
      String? address, 
      String? state, 
      String? zip, 
      String? country, 
      String? city,}){
    _address = address;
    _state = state;
    _zip = zip;
    _country = country;
    _city = city;
}

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _city = json['city'];
  }
  String? _address;
  String? _state;
  String? _zip;
  String? _country;
  String? _city;

  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['city'] = _city;
    return map;
  }

}