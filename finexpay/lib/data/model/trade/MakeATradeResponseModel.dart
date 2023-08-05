import '../auth/registration_response_model.dart';

class MakeATradeResponseModel {
  MakeATradeResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  MakeATradeResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
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
    String? rate,
    String? avgSpeed,
    String? maxLimit,
    String? titleOne,
    String? titleTwo,
    String? heading,
    Ad? ad,
    String? allReviewCount,
    String? positiveReviewCount,
    String? negativeReviewCount,
    List<AllReviews>? allReviews,
    String? prevPageUrl,
    String? nextPageUrl,}){
    _rate = rate;
    _avgSpeed = avgSpeed;
    _maxLimit = maxLimit;
    _titleOne = titleOne;
    _titleTwo = titleTwo;
    _heading = heading;
    _ad = ad;
    _allReviewCount = allReviewCount;
    _positiveReviewCount = positiveReviewCount;
    _negativeReviewCount = negativeReviewCount;
    _allReviews = allReviews;
    _prevPageUrl = prevPageUrl;
    _nextPageUrl = nextPageUrl;
  }

  Data.fromJson(dynamic json) {
    _rate = json['rate']!=null?json['rate'].toString():'00';
    _avgSpeed = json['avg_speed']!=null?json['avg_speed'].toString():'';
    _maxLimit = json['max_limit']!=null?json['max_limit'].toString():'';
    _titleOne = json['title_one']!=null?json['title_one'].toString():'';
    _titleTwo = json['title_two']!=null?json['title_two'].toString():'';
    _heading = json['heading'];
    _ad = json['ad'] != null ? Ad.fromJson(json['ad']) : null;
    _allReviewCount = json['all_review_count']!=null?json['all_review_count'].toString():'00';
    _positiveReviewCount =json['positive_review_count']!=null?json['positive_review_count'].toString():'00';
    _negativeReviewCount = json['negative_review_count']!=null?json['negative_review_count'].toString():'00';
    if (json['all_reviews'] != null) {
      _allReviews = [];
      json['all_reviews'].forEach((v) {
        _allReviews?.add(AllReviews.fromJson(v));
      });
    }
    _prevPageUrl = json['prev_page_url'];
    _nextPageUrl = json['next_page_url'];
  }
  String? _rate;
  String? _avgSpeed;
  String? _maxLimit;
  String? _titleOne;
  String? _titleTwo;
  String? _heading;
  Ad? _ad;
  String? _allReviewCount;
  String? _positiveReviewCount;
  String? _negativeReviewCount;
  List<AllReviews>? _allReviews;
  String? _prevPageUrl;
  String? _nextPageUrl;

  String? get rate      => _rate;
  String? get avgSpeed  => _avgSpeed;
  String? get maxLimit  => _maxLimit;
  String? get titleOne  => _titleOne;
  String? get titleTwo  => _titleTwo;
  String? get heading   => _heading;
  Ad? get ad            => _ad;
  String? get allReviewCount => _allReviewCount;
  String? get positiveReviewCount => _positiveReviewCount;
  String? get negativeReviewCount => _negativeReviewCount;
  List<AllReviews>? get allReviews => _allReviews;
  String? get prevPageUrl => _prevPageUrl;
  String? get nextPageUrl => _nextPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate']      = _rate;
    map['avg_speed'] = _avgSpeed;
    map['max_limit'] = _maxLimit;
    map['title_one'] = _titleOne;
    map['title_two'] = _titleTwo;
    map['heading']   = _heading;
    if (_ad != null) {
      map['ad'] = _ad?.toJson();
    }
    map['all_review_count'] = _allReviewCount;
    map['positive_review_count'] = _positiveReviewCount;
    map['negative_review_count'] = _negativeReviewCount;
    if (_allReviews != null) {
      map['all_reviews'] = _allReviews?.map((v) => v.toJson()).toList();
    }
    map['prev_page_url'] = _prevPageUrl;
    map['next_page_url'] = _nextPageUrl;
    return map;
  }

}

class AllReviews {
  AllReviews({
    int? id,
    String? userId,
    String? type,
    String? feedback,
    String? tradeUid,
    String? image,
    String? username,
    String? createdAt}){
    _id = id;
    _userId=userId;
    _type = type;
    _feedback = feedback;
    _tradeUid = tradeUid;
    _createdAt = createdAt;
    _image = image;
    _username = username;
  }

  AllReviews.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _type = json['type'].toString();
    _feedback = json['feedback'];
    _tradeUid = json['trade_uid'];
    _createdAt = json['created_at'];
    _image = json['user_image'];
    _username = json['user_name'];
  }
  int? _id;
  String? _userId;
  String? _type;
  String? _feedback;
  String? _tradeUid;
  String? _createdAt;
  String? _image;
  String? _username;

  int? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get feedback => _feedback;
  String? get tradeUid => _tradeUid;
  String? get createdAt => _createdAt;
  String? get image => _image;
  String? get username => _username;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['feedback'] = _feedback;
    map['trade_uid'] = _tradeUid;
    map['created_at'] = _createdAt;
    map['user_image'] = _image;
    map['user_name'] = _username;
    return map;
  }
  AllReviews copyWith({
    String? type,
    String? feedback,
  }) {
    return AllReviews(
        type: type ?? _type,
        feedback: feedback ?? _feedback,
        id: id,
        userId: _userId,
        tradeUid: _tradeUid,
      createdAt: createdAt,
      image: _image,
      username: username,
    );}

}

class Ad {
  Ad({
    int? id,
    String? userId,
    String? type,
    String? cryptoCurrencyId,
    String? fiatGatewayId,
    String? fiatCurrencyId,
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
    User? user,
    Crypto? crypto,
    FiatGateway? fiatGateway,
    Fiat? fiat,}){
    _id = id;
    _userId = userId;
    _type = type;
    _cryptoCurrencyId = cryptoCurrencyId;
    _fiatGatewayId = fiatGatewayId;
    _fiatCurrencyId = fiatCurrencyId;
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
    _user = user;
    _crypto = crypto;
    _fiatGateway = fiatGateway;
    _fiat = fiat;
  }

  Ad.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _type = json['type'].toString();
    _cryptoCurrencyId = json['crypto_currency_id'].toString();
    _fiatGatewayId = json['fiat_gateway_id'].toString();
    _fiatCurrencyId = json['fiat_currency_id'].toString();
    _margin = json['margin']!=null?json['margin'].toString():null;
    _fixedPrice = json['fixed_price']!=null?json['fixed_price'].toString():null;
    _window = json['window']!=null?json['window'].toString():null;
    _min = json['min'];
    _max = json['max'];
    _details = json['details'];
    _terms = json['terms'];
    _status = json['status'].toString();
    _completedTrade = json['completed_trade'].toString();
   
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _fiatGateway = json['fiat_gateway'] != null ? FiatGateway.fromJson(json['fiat_gateway']) : null;
    _fiat = json['fiat'] != null ? Fiat.fromJson(json['fiat']) : null;
  }
  int? _id;
  String? _userId;
  String? _type;
  String? _cryptoCurrencyId;
  String? _fiatGatewayId;
  String? _fiatCurrencyId;
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
  User? _user;
  Crypto? _crypto;
  FiatGateway? _fiatGateway;
  Fiat? _fiat;

  int? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get cryptoCurrencyId => _cryptoCurrencyId;
  String? get fiatGatewayId => _fiatGatewayId;
  String? get fiatCurrencyId => _fiatCurrencyId;
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
  User? get user => _user;
  Crypto? get crypto => _crypto;
  FiatGateway? get fiatGateway => _fiatGateway;
  Fiat? get fiat => _fiat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['crypto_currency_id'] = _cryptoCurrencyId;
    map['fiat_gateway_id'] = _fiatGatewayId;
    map['fiat_currency_id'] = _fiatCurrencyId;
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
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
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
    _rate = json['rate'];
    _status = json['status'].toString();
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
    _status = json['status'].toString();
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
    _rate = json['rate'];
    _dcFixed = json['deposit_charge_fixed'];
    _dcPercent = json['deposit_charge_percent'];
    _wcFixed = json['withdraw_charge_fixed'];
    _wcPercent = json['withdraw_charge_percent'];
    _status = json['status'].toString();
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

class User {
  User({
    int? id,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? refBy,
    String? image,
    String? status,
    String? kv,
    String? ev,
    String? sv,
    String? regStep,
    String? ts,
    String? tv,
    String? tsc,
    String? completedTrade,
    String? totalMin,
    String? createdAt,
    String? updatedAt,
  }){
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    
    _image = image;
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
    
    _image = json['image'];
    _status = json['status'].toString();
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
  
  String? _image;
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
  
  String? get image => _image;
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
    
    map['image'] = _image;
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


