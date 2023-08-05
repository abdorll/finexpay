import '../auth/registration_response_model.dart';

class TradeResponseModel {
  TradeResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  TradeResponseModel.fromJson(dynamic json) {
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
  MainData({
      RunningTrades? runningTrades, 
      CompletedTrades? completedTrades, 
      String? gatewayImagePath,}){
    _runningTrades = runningTrades;
    _completedTrades = completedTrades;
    _gatewayImagePath = gatewayImagePath;
}

  MainData.fromJson(dynamic json) {
    _runningTrades = json['running_trades'] != null ? RunningTrades.fromJson(json['running_trades']) : null;
    _completedTrades = json['completed_trades'] != null ? CompletedTrades.fromJson(json['completed_trades']) : null;
    _gatewayImagePath = json['gateway_image_path'];
  }
  RunningTrades? _runningTrades;
  CompletedTrades? _completedTrades;
  String? _gatewayImagePath;

  RunningTrades? get runningTrades => _runningTrades;
  CompletedTrades? get completedTrades => _completedTrades;
  String? get gatewayImagePath => _gatewayImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_runningTrades != null) {
      map['running_trades'] = _runningTrades?.toJson();
    }
    if (_completedTrades != null) {
      map['completed_trades'] = _completedTrades?.toJson();
    }
    map['gateway_image_path'] = _gatewayImagePath;
    return map;
  }

}

class CompletedTrades {
  CompletedTrades({
       
      List<CompletedTradeData>? data,
      
       
      List<Links>? links, 
      dynamic nextPageUrl, 
      }){
   
    _data = data;
    
    
    _links = links;
    _nextPageUrl = nextPageUrl;
    
    
}

  CompletedTrades.fromJson(dynamic json) {
    
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CompletedTradeData.fromJson(v));
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
  
  List<CompletedTradeData>? _data;
  
  
  List<Links>? _links;
  dynamic _nextPageUrl;
  
  

  
  List<CompletedTradeData>? get data => _data;
  
  
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

class CompletedTradeData {
  CompletedTradeData({
      int? id, 
      String? uid, 
      String? advertisementId, 
      String? sellerId, 
      String? buyerId, 
      String? amount, 
      String? cryptoAmount, 
      String? tradeCharge, 
      String? cryptoId, 
      String? fiatGatewayId, 
      String? fiatId, 
      String? exchangeRate, 
      String? window, 
      String? status, 
      String? details, 
      String? paidAt, 
      String? completedAt, 
      String? createdAt, 
      String? updatedAt, 
      Fiat? fiat, 
      FiatGateway? fiatGateway, 
      Crypto? crypto, 
      Buyer? buyer, 
      Seller? seller,}){
    _id = id;
    _uid = uid;
    _advertisementId = advertisementId;
    _sellerId = sellerId;
    _buyerId = buyerId;
    _amount = amount;
    _cryptoAmount = cryptoAmount;
    _tradeCharge = tradeCharge;
    _cryptoId = cryptoId;
    _fiatGatewayId = fiatGatewayId;
    _fiatId = fiatId;
    _exchangeRate = exchangeRate;
    _window = window;
    _status = status;
    _details = details;
    _paidAt = paidAt;
    _completedAt = completedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fiat = fiat;
    _fiatGateway = fiatGateway;
    _crypto = crypto;
    _buyer = buyer;
    _seller = seller;
}

  CompletedTradeData.fromJson(dynamic json) {
    _id = json['id'];
    _uid = json['uid'].toString();
    _advertisementId  = json['advertisement_id']!=null?json['advertisement_id'].toString():null;
    _sellerId = json['seller_id'].toString();
    _buyerId = json['buyer_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():null;;
    _cryptoAmount  = json['crypto_amount']!=null?json['crypto_amount'].toString():null;
    _tradeCharge = json['trade_charge'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _fiatGatewayId = json['fiat_gateway_id'].toString();
    _fiatId = json['fiat_id'].toString();
    _exchangeRate = json['exchange_rate'];
    _window  = json['window']!=null? json['window'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _details = json['details'];
    _paidAt = json['paid_at'];
    _completedAt = json['completed_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fiat = json['fiat'] != null ? Fiat.fromJson(json['fiat']) : null;
    _fiatGateway = json['fiat_gateway'] != null ? FiatGateway.fromJson(json['fiat_gateway']) : null;
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }
  int? _id;
  String? _uid;
  String? _advertisementId;
  String? _sellerId;
  String? _buyerId;
  String? _amount;
  String? _cryptoAmount;
  String? _tradeCharge;
  String? _cryptoId;
  String? _fiatGatewayId;
  String? _fiatId;
  String? _exchangeRate;
  String? _window;
  String? _status;
  String? _details;
  String? _paidAt;
  String? _completedAt;
  String? _createdAt;
  String? _updatedAt;
  Fiat? _fiat;
  FiatGateway? _fiatGateway;
  Crypto? _crypto;
  Buyer? _buyer;
  Seller? _seller;

  int? get id => _id;
  String? get uid => _uid;
  String? get advertisementId => _advertisementId;
  String? get sellerId => _sellerId;
  String? get buyerId => _buyerId;
  String? get amount => _amount;
  String? get cryptoAmount => _cryptoAmount;
  String? get tradeCharge => _tradeCharge;
  String? get cryptoId => _cryptoId;
  String? get fiatGatewayId => _fiatGatewayId;
  String? get fiatId => _fiatId;
  String? get exchangeRate => _exchangeRate;
  String? get window => _window;
  String? get status => _status;
  String? get details => _details;
  String? get paidAt => _paidAt;
  String? get completedAt => _completedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Fiat? get fiat => _fiat;
  FiatGateway? get fiatGateway => _fiatGateway;
  Crypto? get crypto => _crypto;
  Buyer? get buyer => _buyer;
  Seller? get seller => _seller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uid'] = _uid;
    map['advertisement_id'] = _advertisementId;
    map['seller_id'] = _sellerId;
    map['buyer_id'] = _buyerId;
    map['amount'] = _amount;
    map['crypto_amount'] = _cryptoAmount;
    map['trade_charge'] = _tradeCharge;
    map['crypto_id'] = _cryptoId;
    map['fiat_gateway_id'] = _fiatGatewayId;
    map['fiat_id'] = _fiatId;
    map['exchange_rate'] = _exchangeRate;
    map['window'] = _window;
    map['status'] = _status;
    map['details'] = _details;
    map['paid_at'] = _paidAt;
    map['completed_at'] = _completedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_fiat != null) {
      map['fiat'] = _fiat?.toJson();
    }
    if (_fiatGateway != null) {
      map['fiat_gateway'] = _fiatGateway?.toJson();
    }
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    if (_buyer != null) {
      map['buyer'] = _buyer?.toJson();
    }
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    return map;
  }

}

class Seller {
  Seller({
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
      String? verCode, 
      String? verCodeSendAt, 
      String? ts, 
      String? tv, 
      dynamic tsc, 
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

  Seller.fromJson(dynamic json) {
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
  String? _verCode;
  String? _verCodeSendAt;
  String? _ts;
  String? _tv;
  dynamic _tsc;
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
  String? get verCode => _verCode;
  String? get verCodeSendAt => _verCodeSendAt;
  String? get ts => _ts;
  String? get tv => _tv;
  dynamic get tsc => _tsc;
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
      String? city, 
      String? state, 
      String? zip, 
      String? country,}){
    _address = address;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
}

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
  }
  String? _address;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;

  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }

}

class Buyer {
  Buyer({
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

  Buyer.fromJson(dynamic json) {
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

class FiatGateway {
  FiatGateway({
      int? id, 
      String? name, 
      String? slug, 
      
      dynamic image, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _slug = slug;
    
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FiatGateway.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    
    _image = json['image'];
    _status = json['status']!=null? json['status'].toString():null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _slug;
  
  dynamic _image;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  
  dynamic get image => _image;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Fiat {
  Fiat({
      int? id, 
      String? name, 
      String? code, 
      String? symbol, 
      String? rate, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _code = code;
    _symbol = symbol;
    _rate = rate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Fiat.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _symbol = json['symbol'];
   _rate = json['rate']!=null?json['rate'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _code;
  String? _symbol;
  String? _rate;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get symbol => _symbol;
  String? get rate => _rate;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    
    map['symbol'] = _symbol;
    map['rate'] = _rate;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class RunningTrades {
  RunningTrades({
       
      List<RunningTradeData>? data,
      
       
      List<Links>? links, 
      dynamic nextPageUrl, 
      }){
   
    _data = data;
    
    
    _links = links;
    _nextPageUrl = nextPageUrl;
    
    
}

  RunningTrades.fromJson(dynamic json) {
    
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RunningTradeData.fromJson(v));
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
  
  List<RunningTradeData>? _data;
  
  
  List<Links>? _links;
  dynamic _nextPageUrl;
  
  

  
  List<RunningTradeData>? get data => _data;
  
  
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

class RunningTradeData {
  RunningTradeData({
      int? id, 
      String? uid, 
      String? advertisementId, 
      String? sellerId, 
      String? buyerId, 
      String? amount, 
      String? cryptoAmount, 
      String? tradeCharge, 
      String? cryptoId, 
      String? fiatGatewayId, 
      String? fiatId, 
      String? exchangeRate, 
      String? window, 
      String? status, 
      String? details, 
      String? paidAt, 
      String? completedAt, 
      String? createdAt, 
      String? updatedAt, 
      Fiat? fiat, 
      FiatGateway? fiatGateway, 
      Crypto? crypto, 
      Buyer? buyer, 
      Seller? seller,}){
    _id = id;
    _uid = uid;
    _advertisementId = advertisementId;
    _sellerId = sellerId;
    _buyerId = buyerId;
    _amount = amount;
    _cryptoAmount = cryptoAmount;
    _tradeCharge = tradeCharge;
    _cryptoId = cryptoId;
    _fiatGatewayId = fiatGatewayId;
    _fiatId = fiatId;
    _exchangeRate = exchangeRate;
    _window = window;
    _status = status;
    _details = details;
    _paidAt = paidAt;
    _completedAt = completedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fiat = fiat;
    _fiatGateway = fiatGateway;
    _crypto = crypto;
    _buyer = buyer;
    _seller = seller;
}

  RunningTradeData.fromJson(dynamic json) {
    _id = json['id'];
    _uid = json['uid'].toString();
    _advertisementId  = json['advertisement_id']!=null?json['advertisement_id'].toString():null;
    _sellerId = json['seller_id'].toString();
    _buyerId = json['buyer_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():null;;
    _cryptoAmount  = json['crypto_amount']!=null?json['crypto_amount'].toString():null;
    _tradeCharge = json['trade_charge'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _fiatGatewayId = json['fiat_gateway_id'].toString();
    _fiatId = json['fiat_id'].toString();
    _exchangeRate = json['exchange_rate'];
    _window  = json['window']!=null? json['window'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _details = json['details'];
    _paidAt = json['paid_at'];
    _completedAt = json['completed_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fiat = json['fiat'] != null ? Fiat.fromJson(json['fiat']) : null;
    _fiatGateway = json['fiat_gateway'] != null ? FiatGateway.fromJson(json['fiat_gateway']) : null;
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }
  int? _id;
  String? _uid;
  String? _advertisementId;
  String? _sellerId;
  String? _buyerId;
  String? _amount;
  String? _cryptoAmount;
  String? _tradeCharge;
  String? _cryptoId;
  String? _fiatGatewayId;
  String? _fiatId;
  String? _exchangeRate;
  String? _window;
  String? _status;
  String? _details;
  String? _paidAt;
  String? _completedAt;
  String? _createdAt;
  String? _updatedAt;
  Fiat? _fiat;
  FiatGateway? _fiatGateway;
  Crypto? _crypto;
  Buyer? _buyer;
  Seller? _seller;

  int? get id => _id;
  String? get uid => _uid;
  String? get advertisementId => _advertisementId;
  String? get sellerId => _sellerId;
  String? get buyerId => _buyerId;
  String? get amount => _amount;
  String? get cryptoAmount => _cryptoAmount;
  String? get tradeCharge => _tradeCharge;
  String? get cryptoId => _cryptoId;
  String? get fiatGatewayId => _fiatGatewayId;
  String? get fiatId => _fiatId;
  String? get exchangeRate => _exchangeRate;
  String? get window => _window;
  String? get status => _status;
  String? get details => _details;
  String? get paidAt => _paidAt;
  String? get completedAt => _completedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Fiat? get fiat => _fiat;
  FiatGateway? get fiatGateway => _fiatGateway;
  Crypto? get crypto => _crypto;
  Buyer? get buyer => _buyer;
  Seller? get seller => _seller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uid'] = _uid;
    map['advertisement_id'] = _advertisementId;
    map['seller_id'] = _sellerId;
    map['buyer_id'] = _buyerId;
    map['amount'] = _amount;
    map['crypto_amount'] = _cryptoAmount;
    map['trade_charge'] = _tradeCharge;
    map['crypto_id'] = _cryptoId;
    map['fiat_gateway_id'] = _fiatGatewayId;
    map['fiat_id'] = _fiatId;
    map['exchange_rate'] = _exchangeRate;
    map['window'] = _window;
    map['status'] = _status;
    map['details'] = _details;
    map['paid_at'] = _paidAt;
    map['completed_at'] = _completedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_fiat != null) {
      map['fiat'] = _fiat?.toJson();
    }
    if (_fiatGateway != null) {
      map['fiat_gateway'] = _fiatGateway?.toJson();
    }
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    if (_buyer != null) {
      map['buyer'] = _buyer?.toJson();
    }
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    return map;
  }

}










