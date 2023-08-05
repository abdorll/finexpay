
import '../auth/registration_response_model.dart';

class MarketPlaceResponseModel {
  MarketPlaceResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  MarketPlaceResponseModel.fromJson(dynamic json) {
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
      String? type, 
      String? userImagePath, 
      String? gatewayImagePath, 
      List<Ads>? ads, 
      dynamic prevPageUrl, 
      dynamic nextPageUrl,}){
    _type = type;
    _userImagePath = userImagePath;
    _gatewayImagePath = gatewayImagePath;
    _ads = ads;
    _prevPageUrl = prevPageUrl;
    _nextPageUrl = nextPageUrl;
}

  Data.fromJson(dynamic json) {
    _type = json['type'].toString();
    _userImagePath = json['user_image_path'];
    _gatewayImagePath = json['gateway_image_path'];
    if (json['ads'] != null) {
      _ads = [];
      json['ads'].forEach((v) {
        _ads?.add(Ads.fromJson(v));
      });
    }
    _prevPageUrl = json['prev_page_url'];
    _nextPageUrl = json['next_page_url'];
  }
  String? _type;
  String? _userImagePath;
  String? _gatewayImagePath;
  List<Ads>? _ads;
  dynamic _prevPageUrl;
  dynamic _nextPageUrl;

  String? get type => _type;
  String? get userImagePath => _userImagePath;
  String? get gatewayImagePath => _gatewayImagePath;
  List<Ads>? get ads => _ads;
  
  dynamic get nextPageUrl => _nextPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['user_image_path'] = _userImagePath;
    map['gateway_image_path'] = _gatewayImagePath;
    if (_ads != null) {
      map['ads'] = _ads?.map((v) => v.toJson()).toList();
    }
    map['prev_page_url'] = _prevPageUrl;
    map['next_page_url'] = _nextPageUrl;
    return map;
  }

}

class Ads {
  Ads({
      int? id, 
      String? userUsername, 
      String? userId,
      String? userImage, 
      String? fiatGateway, 
      String? fiatGatewayImage, 
      String? rate,
      String? rateCurrency,
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
    _rateCurrency =  rateCurrency;
    _window = window;
    _maxLimit = maxLimit;
    _avgSpeed = avgSpeed;
}

  Ads.fromJson(dynamic json) {
    _id = json['id'];
    _userUsername = json['user_username'];
    _userId = json['user_id'].toString();
    _userImage = json['user_image'];
    _fiatGateway = json['fiat_gateway'];
    _fiatGatewayImage = json['fiat_gateway_image'];
    _rate = json['rate']!=null?json['rate'].toString():'0';
    _rateCurrency = json['rate_attribute']!=null?json['rate_attribute'].toString():'';
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
  String? _rateCurrency;
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
  String? get rateCurrency => _rateCurrency;
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
    map['rate_attribute'] = _rateCurrency;
    map['window'] = _window;
    map['max_limit'] = _maxLimit;
    map['avg_speed'] = _avgSpeed;
    return map;
  }

}
