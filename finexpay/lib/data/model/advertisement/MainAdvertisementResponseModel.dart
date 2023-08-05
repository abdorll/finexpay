
import '../auth/registration_response_model.dart';

class MainAdvertisementResponseModel {
  MainAdvertisementResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  MainAdvertisementResponseModel.fromJson(dynamic json) {
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
  MainData? get mainData => _mainData;

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
    int? adCount,
    String? cryptoImagePath,
    String? gatewayImagePath,
    List<Ads>? ads,
    String? prevPageUrl,
    String? nextPageUrl,}){
    _adCount = adCount;
    _cryptoImagePath = cryptoImagePath;
    _gatewayImagePath = gatewayImagePath;
    _ads = ads;
    _prevPageUrl = prevPageUrl;
    _nextPageUrl = nextPageUrl;
  }

  MainData.fromJson(dynamic json) {
    _adCount = json['ad_count'];
    _cryptoImagePath = json['crypto_image_path'];
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
  int? _adCount;
  String? _cryptoImagePath;
  String? _gatewayImagePath;
  List<Ads>? _ads;
  String? _prevPageUrl;
  String? _nextPageUrl;

  int? get adCount => _adCount;
  String? get cryptoImagePath => _cryptoImagePath;
  String? get gatewayImagePath => _gatewayImagePath;
  List<Ads>? get ads => _ads;
  String? get prevPageUrl => _prevPageUrl;
  String? get nextPageUrl => _nextPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ad_count'] = _adCount;
    map['crypto_image_path'] = _cryptoImagePath;
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
    String? cryptoCode,
    String? cryptoImage,
    String? fiatGateway,
    dynamic fiatGatewayImage,
    String? rate,
    String? rateCurrency,
    String? window,
    String? status,
    int? publish,
   // UnpublishReason? unpublishReason,
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
   // _unpublishReason = unpublishReason;
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
      _unpublishReason = [];
      json['unpublish_reason'].forEach((v) {
        _unpublishReason?.add(v);
      });
    }
    _fixedMargin = json['fixed_margin'];
    _type = json['type'].toString();
  }
  int? _id;
  String? _cryptoCode;
  String? _cryptoImage;
  String? _fiatGateway;
  dynamic _fiatGatewayImage;
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
  List<String>? get unpublishReason => _unpublishReason;
  String? get fixedMargin => _fixedMargin;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['crypto_code'] = _cryptoCode;
    map['crypto_image'] = _cryptoImage;
    map['fiat_gateway'] = _fiatGateway;
    map['fiat_gateway_image'] = _fiatGatewayImage;
    map['rate'] = _rate;
    map['window'] = _window;
    map['status'] = _status;
    map['publish'] = _publish;
    map['fixed_margin'] = _fixedMargin;
    map['type'] = _type;
    return map;
  }

}




