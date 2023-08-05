import '../auth/registration_response_model.dart';

class NewAdvertisementResponseModel {
  NewAdvertisementResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  NewAdvertisementResponseModel.fromJson(dynamic json) {
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
    String? sellChargeMessage,
    Ad? ad,
    List<Cryptos>? cryptos,
    List<PaymentWindows>? paymentWindows,
    List<FiatGateways>? fiatGateways,}){
    _sellChargeMessage = sellChargeMessage;
    _ad = ad;
    _cryptos = cryptos;
    _paymentWindows = paymentWindows;
    _fiatGateways = fiatGateways;
  }

  Data.fromJson(dynamic json) {
    _sellChargeMessage = json['sell_charge_message'];
    _ad = json['ad'] != null ? Ad.fromJson(json['ad']) : null;
    if (json['cryptos'] != null) {
      _cryptos = [];
      json['cryptos'].forEach((v) {
        _cryptos?.add(Cryptos.fromJson(v));
      });
    }
    if (json['payment_windows'] != null) {
      _paymentWindows = [];
      json['payment_windows'].forEach((v) {
        _paymentWindows?.add(PaymentWindows.fromJson(v));
      });
    }
    if (json['fiat_gateways'] != null) {
      _fiatGateways = [];
      json['fiat_gateways'].forEach((v) {
        _fiatGateways?.add(FiatGateways.fromJson(v));
      });
    }
  }
  String? _sellChargeMessage;
  Ad? _ad;
  List<Cryptos>? _cryptos;
  List<PaymentWindows>? _paymentWindows;
  List<FiatGateways>? _fiatGateways;

  String? get sellChargeMessage => _sellChargeMessage;
  Ad? get ad => _ad;
  List<Cryptos>? get cryptos => _cryptos;
  List<PaymentWindows>? get paymentWindows => _paymentWindows;
  List<FiatGateways>? get fiatGateways => _fiatGateways;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sell_charge_message'] = _sellChargeMessage;
    if (_ad != null) {
      map['ad'] = _ad?.toJson();
    }
    if (_cryptos != null) {
      map['cryptos'] = _cryptos?.map((v) => v.toJson()).toList();
    }
    if (_paymentWindows != null) {
      map['payment_windows'] = _paymentWindows?.map((v) => v.toJson()).toList();
    }
    if (_fiatGateways != null) {
      map['fiat_gateways'] = _fiatGateways?.map((v) => v.toJson()).toList();
    }
    return map;
  }

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
    String? updatedAt,}){
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
    _window  = json['window']!=null? json['window'].toString():null;
    _min = json['min'].toString();
    _max = json['max'].toString();
    _details = json['details'];
    _terms = json['terms'];
    _status = json['status']!=null? json['status'].toString():null;
    _completedTrade = json['completed_trade'].toString();
   
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
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

class PaymentWindows {
  PaymentWindows({
    int? id,
    String? minute,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _minute = minute;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  PaymentWindows.fromJson(dynamic json) {
    _id = json['id'];
    _minute = json['minute']!=null?json['minute'].toString():null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _minute;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get minute => _minute;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['minute'] = _minute;
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



