import '../auth/registration_response_model.dart';

class PublicProfileResponseModel {
  PublicProfileResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  PublicProfileResponseModel.fromJson(dynamic json) {
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
      String? userImagePath, 
      String? gatewayImagePath, 
      User? user, 
      List<BuyAds>? buyAds, 
      List<SellAds>? sellAds, 
      String? allReviewCount, 
      String? buyAdsNextPageUrl, 
      String? sellAdsNextPageUrl, 
      String? positiveReviewCount, 
      String? negativeReviewCount, 
      List<Cryptos>? cryptos, 
      List<FiatGateways>? fiatGateways,}){
    _userImagePath = userImagePath;
    _gatewayImagePath = gatewayImagePath;
    _user = user;
    _buyAds = buyAds;
    _sellAds = sellAds;
    _allReviewCount = allReviewCount;
    _buyAdsNextPageUrl = buyAdsNextPageUrl;
    _sellAdsNextPageUrl = sellAdsNextPageUrl;
    _positiveReviewCount = positiveReviewCount;
    _negativeReviewCount = negativeReviewCount;
    _cryptos = cryptos;
    _fiatGateways = fiatGateways;
}

  Data.fromJson(dynamic json) {
    _userImagePath = json['user_image_path'];
    _gatewayImagePath = json['gateway_image_path'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['buy_ads'] != null) {
      _buyAds = [];
      json['buy_ads'].forEach((v) {
        _buyAds?.add(BuyAds.fromJson(v));
      });
    }
    if (json['sell_ads'] != null) {
      _sellAds = [];
      json['sell_ads'].forEach((v) {
        _sellAds?.add(SellAds.fromJson(v));
      });
    }
    _allReviewCount = json['all_review_count'].toString();
    _buyAdsNextPageUrl = json['buy_ads_next_page_url'];
    _sellAdsNextPageUrl = json['sell_ads_next_page_url'];
    _positiveReviewCount = json['positive_review_count'].toString();
    _negativeReviewCount = json['negative_review_count'].toString();
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
  String? _userImagePath;
  String? _gatewayImagePath;
  User? _user;
  List<BuyAds>? _buyAds;
  List<SellAds>? _sellAds;
  String? _allReviewCount;
  String? _buyAdsNextPageUrl;
  String? _sellAdsNextPageUrl;
  String? _positiveReviewCount;
  String? _negativeReviewCount;
  List<Cryptos>? _cryptos;
  List<FiatGateways>? _fiatGateways;

  String? get userImagePath => _userImagePath;
  String? get gatewayImagePath => _gatewayImagePath;
  User? get user => _user;
  List<BuyAds>? get buyAds => _buyAds;
  List<SellAds>? get sellAds => _sellAds;
  String? get allReviewCount => _allReviewCount;
  String? get buyAdsNextPageUrl => _buyAdsNextPageUrl;
  String? get sellAdsNextPageUrl => _sellAdsNextPageUrl;
  String? get positiveReviewCount => _positiveReviewCount;
  String? get negativeReviewCount => _negativeReviewCount;
  List<Cryptos>? get cryptos => _cryptos;
  List<FiatGateways>? get fiatGateways => _fiatGateways;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_image_path'] = _userImagePath;
    map['gateway_image_path'] = _gatewayImagePath;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_buyAds != null) {
      map['buy_ads'] = _buyAds?.map((v) => v.toJson()).toList();
    }
    if (_sellAds != null) {
      map['sell_ads'] = _sellAds?.map((v) => v.toJson()).toList();
    }
    map['all_review_count'] = _allReviewCount;
    map['buy_ads_next_page_url'] = _buyAdsNextPageUrl;
    map['sell_ads_next_page_url'] = _sellAdsNextPageUrl;
    map['positive_review_count'] = _positiveReviewCount;
    map['negative_review_count'] = _negativeReviewCount;
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

  FiatGateways.fromJson(dynamic json) {
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

class SellAds {
  SellAds({
      int? id, 
      String? userUsername, 
      String? userId, 
      String? userImage, 
      String? fiatGateway, 
      String? fiatGatewayImage, 
      String? rate,
      String? currency,
      String? window, 
      String? maxLimit, 
      String? avgSpeed,}){
    _id = id;
    _userUsername = userUsername;
    _userId = userId;
    _userImage = userImage;
    _fiatGateway = fiatGateway;
    _fiatGatewayImage = fiatGatewayImage;
    _rate = rate;
    _currency = currency;
    _window = window;
    _maxLimit = maxLimit;
    _avgSpeed = avgSpeed;
}

  SellAds.fromJson(dynamic json) {
    _id = json['id'];
    _userUsername = json['user_username'];
    _userId = json['user_id'].toString();
    _userImage = json['user_image'];
    _fiatGateway = json['fiat_gateway'];
    _fiatGatewayImage = json['fiat_gateway_image'];
    _rate = json['rate']!=null?json['rate'].toString():null;
    _currency = json['rate_attribute']!=null?json['rate_attribute'].toString():'-';
    _window  = json['window']!=null? json['window'].toString():null;
    _maxLimit = json['max_limit'];
    _avgSpeed = json['avg_speed'];
  }
  int? _id;
  String? _userUsername;
  String? _userId;
  String? _userImage;
  String? _fiatGateway;
  String? _fiatGatewayImage;
  String? _rate;

  String? _currency;
  String? _window;
  String? _maxLimit;
  String? _avgSpeed;

  int? get id => _id;
  String? get userUsername => _userUsername;
  String? get userId => _userId;
  String? get userImage => _userImage;
  String? get fiatGateway => _fiatGateway;
  String? get fiatGatewayImage => _fiatGatewayImage;
  String? get rate => _rate;
  String? get currency => _currency;
  String? get window => _window;
  String? get maxLimit => _maxLimit;
  String? get avgSpeed => _avgSpeed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_username'] = _userUsername;
    map['user_id'] = _userId;
    map['user_image'] = _userImage;
    map['fiat_gateway'] = _fiatGateway;
    map['fiat_gateway_image'] = _fiatGatewayImage;
    map['rate'] = _rate;
    map['rate_attribute'] = _currency;
    map['window'] = _window;
    map['max_limit'] = _maxLimit;
    map['avg_speed'] = _avgSpeed;
    return map;
  }

}

class BuyAds {
  BuyAds({
      int? id, 
      String? userUsername, 
      String? userId, 
      String? userImage, 
      String? fiatGateway, 
      String? fiatGatewayImage, 
      String? rate,
      String? currency,
      String? window, 
      String? maxLimit, 
      String? avgSpeed,}){
    _id = id;
    _userUsername = userUsername;
    _userId = userId;
    _userImage = userImage;
    _fiatGateway = fiatGateway;
    _fiatGatewayImage = fiatGatewayImage;
    _rate = rate;
    _currency = currency;
    _window = window;
    _maxLimit = maxLimit;
    _avgSpeed = avgSpeed;
}

  BuyAds.fromJson(dynamic json) {
    _id = json['id'];
    _userUsername = json['user_username'];
    _userId = json['user_id'].toString();
    _userImage = json['user_image'];
    _fiatGateway = json['fiat_gateway'];
    _fiatGatewayImage = json['fiat_gateway_image'];
   _rate = json['rate']!=null?json['rate'].toString():null;
   _currency = json['rate_attribute']!=null?json['rate_attribute'].toString():'-';
    _window  = json['window']!=null? json['window'].toString():null;
    _maxLimit = json['max_limit'];
    _avgSpeed = json['avg_speed'];
  }
  int? _id;
  String? _userUsername;
  String? _userId;
  String? _userImage;
  String? _fiatGateway;
  String? _fiatGatewayImage;
  String? _rate;
  String? _window;
  String? _maxLimit;
  String? _avgSpeed;
  String? _currency;

  int? get id => _id;
  String? get userUsername => _userUsername;
  String? get userId => _userId;
  String? get userImage => _userImage;
  String? get fiatGateway => _fiatGateway;
  String? get fiatGatewayImage => _fiatGatewayImage;
  String? get rate => _rate;
  String? get currency => _currency;
  String? get window => _window;
  String? get maxLimit => _maxLimit;
  String? get avgSpeed => _avgSpeed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_username'] = _userUsername;
    map['user_id'] = _userId;
    map['user_image'] = _userImage;
    map['fiat_gateway'] = _fiatGateway;
    map['fiat_gateway_image'] = _fiatGatewayImage;
    map['rate'] = _rate;
    map['rate_attribute'] = _currency;
    map['window'] = _window;
    map['max_limit'] = _maxLimit;
    map['avg_speed'] = _avgSpeed;
    return map;
  }

}

class User {
  User({
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

  User.fromJson(dynamic json) {
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

