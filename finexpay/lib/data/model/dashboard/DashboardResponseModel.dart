
import '../auth/registration_response_model.dart';

class DashboardResponseModel {

  DashboardResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  DashboardResponseModel.fromJson(dynamic json) {
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
  String? gatewayImagePath,
  List<Wallets>? wallets,
  String? totalBuyAdd,
  String? totalSellAdd,
  String? runningTradeCount,
  String? completedTradeCount,
  String? cryptoImagePath,
  String? userImagePath,
  UserInfo? userInfo,
  List<Ads>? ads,
  String? referralLink,}){
    _gatewayImagePath = gatewayImagePath;
    _wallets = wallets;
    _totalBuyAdd = totalBuyAdd;
    _totalSellAdd = totalSellAdd;
    _runningTradeCount = runningTradeCount;
    _completedTradeCount = completedTradeCount;
    _cryptoImagePath = cryptoImagePath;
    _userImagePath = userImagePath;
    _userInfo = userInfo;
    _ads = ads;
    _referralLink = referralLink;
}

  MainData.fromJson(dynamic json) {
    _gatewayImagePath = json['gateway_image_path'];
    if (json['wallets'] != null) {
      _wallets = [];
      json['wallets'].forEach((v) {
        _wallets?.add(Wallets.fromJson(v));
      });
    }
    _totalBuyAdd = json['total_buy_add']!=null?json['total_buy_add'].toString():null;
    _totalSellAdd = json['total_sell_add']!=null?json['total_sell_add'].toString():null;
    _runningTradeCount = json['running_trade_count']!=null?json['running_trade_count'].toString():null;
    _completedTradeCount = json['completed_trade_count']!=null?json['completed_trade_count'].toString():null;
    _cryptoImagePath = json['crypto_image_path'];
    _userImagePath = json['user_image_path'];
    _userInfo = json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
    if (json['ads'] != null) {
      _ads = [];
      json['ads'].forEach((v) {
        _ads?.add(Ads.fromJson(v));
      });
    }
    _referralLink = json['referral_link'];
  }
  String? _gatewayImagePath;
  List<Wallets>? _wallets;
  String? _totalBuyAdd;
  String? _totalSellAdd;
  String? _runningTradeCount;
  String? _completedTradeCount;
  String? _cryptoImagePath;
  String? _userImagePath;
  UserInfo? _userInfo;
  List<Ads>? _ads;
  String? _referralLink;

  String? get gatewayImagePath => _gatewayImagePath;
  List<Wallets>? get wallets => _wallets;
  String? get totalBuyAdd => _totalBuyAdd;
  String? get totalSellAdd => _totalSellAdd;
  String? get runningTradeCount => _runningTradeCount;
  String? get completedTradeCount => _completedTradeCount;
  String? get cryptoImagePath => _cryptoImagePath;
  String? get userImagePath => _userImagePath;
  UserInfo? get userInfo => _userInfo;
  List<Ads>? get ads => _ads;
  String? get referralLink => _referralLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gateway_image_path'] = _gatewayImagePath;
    if (_wallets != null) {
      map['wallets'] = _wallets?.map((v) => v.toJson()).toList();
    }
    map['total_buy_add'] = _totalBuyAdd;
    map['total_sell_add'] = _totalSellAdd;
    map['running_trade_count'] = _runningTradeCount;
    map['completed_trade_count'] = _completedTradeCount;
    map['crypto_image_path'] = _cryptoImagePath;
    map['user_image_path'] = _userImagePath;
    if (_userInfo != null) {
      map['user_info'] = _userInfo?.toJson();
    }
    map['referral_link'] = _referralLink;
    return map;
  }

}

class Ads {
  Ads({
    int? id,
    String? cryptoCode,
    String? cryptoImage,
    String? fiatGateway,
    String? fiatGatewayImage,
    String? rate,
    String? rateCurrency,
    String? window,
    String? status,
    int? publish,
    List<String>? unpublishReason,
    String? fixedMargin,
    String? type,}){
    _id = id;
    _cryptoCode = cryptoCode;
    _cryptoImage = cryptoImage;
    _fiatGateway = fiatGateway;
    _fiatGatewayImage = fiatGatewayImage;
    _rate = rate;
    _rateCurrency = rateCurrency;
    _window = window;
    _status = status;
    _publish = publish;
    _unpublishReason = unpublishReason;
    _fixedMargin = fixedMargin;
    _type = type;
  }

  Ads.fromJson(dynamic json) {
    _id = json['id'];
    _cryptoCode = json['crypto_code'];
    _cryptoImage = json['crypto_image'];
    _fiatGateway = json['fiat_gateway'];
    _fiatGatewayImage = json['fiat_gateway_image'];
    _rate = json['rate']!=null?json['rate'].toString():'0';
    _rateCurrency = json['rate_attribute']!=null?json['rate_attribute'].toString():'';
    _window  = json['window']!=null? json['window'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _publish = json['publish'];
    if (json['unpublish_reason'] != null) {
      _unpublishReason = [json['unpublish_reason'].toString()];
    }
    _fixedMargin = json['fixed_margin'];
    _type = json['type'].toString();
  }
  int? _id;
  String? _cryptoCode;
  String? _cryptoImage;
  String? _fiatGateway;
  String? _fiatGatewayImage;
  String? _rate;
  String? _rateCurrency;
  String? _window;
  String? _status;
  int? _publish;
  List<String>? _unpublishReason;
  String? _fixedMargin;
  String? _type;

  int? get id => _id;
  String? get cryptoCode => _cryptoCode;
  String? get cryptoImage => _cryptoImage;
  String? get fiatGateway => _fiatGateway;
  dynamic get fiatGatewayImage => _fiatGatewayImage;
  String? get rate => _rate;
  String? get rateCurrency => _rateCurrency;
  String? get window => _window;
  String? get status => _status;
  int? get publish => _publish;
  List<dynamic>? get unpublishReason => _unpublishReason;
  String? get fixedMargin => _fixedMargin;
  String? get type => _type;

  Ads copyWith({
    String? status,
  }) {
    return Ads(
      id: id ?? this._id,
      cryptoCode: this._cryptoCode,
      cryptoImage: this._cryptoImage,
      fiatGateway: this._fiatGateway,
      fiatGatewayImage: this._fiatGatewayImage,
      rate: this._rate,
      rateCurrency: this._rateCurrency,
      window: this._window,
      status: status??this._status,
      publish: this._publish,
      unpublishReason:this._unpublishReason,
      fixedMargin: this._fixedMargin,
      type: type ?? this._type,
    );
  }
}



class Data {
  Data({
      int? id, 
      String? userId, 
      String? type, 
      String? cryptoId, 
      String? fiatGatewayId, 
      String? fiatId, 
      String? margin, 
      String? fixedPrice, 
      String? window, 
      String? min, 
      String? max, 
      String? details, 
      String? terms, 
      String? status, 
      String? completedTrade, 
      String? totalMin, 
      String? createdAt, 
      String? updatedAt, 
      Crypto? crypto, 
      FiatGateway? fiatGateway, 
      Fiat? fiat,}){
    _id = id;
    _userId = userId;
    _type = type;
    _cryptoId = cryptoId;
    _fiatGatewayId = fiatGatewayId;
    _fiatId = fiatId;
    _margin = margin;
    _fixedPrice = fixedPrice;
    _window = window;
    _min = min;
    _max = max;
    _details = details;
    _terms = terms;
    _status = status;
    _completedTrade = completedTrade;
    _totalMin = totalMin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _crypto = crypto;
    _fiatGateway = fiatGateway;
    _fiat = fiat;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _type = json['type'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _fiatGatewayId = json['fiat_gateway_id'].toString();
    _fiatId = json['fiat_id'].toString();
    _margin = json['margin']!=null?json['margin'].toString():null;
    _fixedPrice = json['fixed_price']!=null?json['fixed_price'].toString():null;
    _window  = json['window']!=null? json['window'].toString():null;
    _min = json['min'];
    _max = json['max'];
    _details = json['details'];
    _terms = json['terms'];
    _status = json['status']!=null? json['status'].toString():null;
    _completedTrade = json['completed_trade'].toString();
   
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _fiatGateway = json['fiat_gateway'] != null ? FiatGateway.fromJson(json['fiat_gateway']) : null;
    _fiat = json['fiat'] != null ? Fiat.fromJson(json['fiat']) : null;
  }
  int? _id;
  String? _userId;
  String? _type;
  String? _cryptoId;
  String? _fiatGatewayId;
  String? _fiatId;
  String? _margin;
  String? _fixedPrice;
  String? _window;
  String? _min;
  String? _max;
  String? _details;
  String? _terms;
  String? _status;
  String? _completedTrade;
  String? _totalMin;
  String? _createdAt;
  String? _updatedAt;
  Crypto? _crypto;
  FiatGateway? _fiatGateway;
  Fiat? _fiat;

  int? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get cryptoId => _cryptoId;
  String? get fiatGatewayId => _fiatGatewayId;
  String? get fiatId => _fiatId;
  String? get margin => _margin;
  String? get fixedPrice => _fixedPrice;
  String? get window => _window;
  String? get min => _min;
  String? get max => _max;
  String? get details => _details;
  String? get terms => _terms;
  String? get status => _status;
  String? get completedTrade => _completedTrade;
  String? get totalMin => _totalMin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Crypto? get crypto => _crypto;
  FiatGateway? get fiatGateway => _fiatGateway;
  Fiat? get fiat => _fiat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['crypto_id'] = _cryptoId;
    map['fiat_gateway_id'] = _fiatGatewayId;
    map['fiat_id'] = _fiatId;
    map['margin'] = _margin;
    map['fixed_price'] = _fixedPrice;
    map['window'] = _window;
    map['min'] = _min;
    map['max'] = _max;
    map['details'] = _details;
    map['terms'] = _terms;
    map['status'] = _status;
    map['completed_trade'] = _completedTrade;
    map['total_min'] = _totalMin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    if (_fiatGateway != null) {
      map['fiat_gateway'] = _fiatGateway?.toJson();
    }
    if (_fiat != null) {
      map['fiat'] = _fiat?.toJson();
    }
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

class FiatGateway {
  FiatGateway({
      int? id, 
      String? name, 
      String? slug, 
      
      String? image, 
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
  
  String? _image;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  
  String? get image => _image;
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
    _id = json['cryptoId'];
    _name = json['cryptoCode'];
    _code = json['cryptoCode'];
    _symbol = json['symbol'];
    _rate = json['rate']!=null?json['rate'].toString():'';
    _dcFixed = json['deposit_charge_fixed'].toString();
    _dcPercent = json['deposit_charge_fixed'].toString();
    _wcFixed = json['deposit_charge_fixed'].toString();
    _wcPercent = json['deposit_charge_fixed'].toString();
    _status = json['deposit_charge_fixed'].toString();
    _image = json['cryptoImage'];
    _balanceInUsd = json['balanceInUsd']!=null?json['balanceInUsd'].toString():'0';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _code;
  String? _balanceInUsd;
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
  String? get usdBalance => _balanceInUsd;
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

class UserInfo {
  UserInfo({
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

  UserInfo.fromJson(dynamic json) {
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
    _tv = json['tv'].toString();
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
      String? country, 
      String? address, 
      String? state, 
      String? zip, 
      String? city,}){
    _country = country;
    _address = address;
    _state = state;
    _zip = zip;
    _city = city;
}

  Address.fromJson(dynamic json) {
    _country = json['country'];
    _address = json['address'];
    _state = json['state'];
    _zip = json['zip'];
    _city = json['city'];
  }
  String? _country;
  String? _address;
  String? _state;
  String? _zip;
  String? _city;

  String? get country => _country;
  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['city'] = _city;
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
      String? updatedAt}){
    _id = id;
    _userId = userId;
    _cryptoId = cryptoId;
    _balance = balance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Wallets.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _cryptoId = json['cryptoId'].toString();
    _cryptoCode = json['cryptoCode'].toString();
    _balance = json['balance'].toString();
    _balanceInUSD = json['balanceInUsd'].toString();
    _image = json['cryptoImage'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _cryptoId;
  String? _cryptoCode;
  String? _balance;
  String? _balanceInUSD;
  String? _image;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get cryptoId => _cryptoId;
  String? get cryptoCode => _cryptoCode;
  String? get balance => _balance;
  String? get balanceInUSD => _balanceInUSD;
  String? get image => _image;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['crypto_id'] = _cryptoId;
    map['balance'] = _balance;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

