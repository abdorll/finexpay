import '../auth/registration_response_model.dart';

class AdvertisementReviewResponseModel {
  AdvertisementReviewResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  AdvertisementReviewResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainData = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _mainData;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _mainData;

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

class Data {
  Data({
    List<Reviews>? reviews,
    dynamic nextPageUrl,}){
    _reviews = reviews;
    _nextPageUrl = nextPageUrl;
  }

  Data.fromJson(dynamic json) {
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }
  List<Reviews>? _reviews;
  dynamic _nextPageUrl;

  List<Reviews>? get reviews => _reviews;
  dynamic get nextPageUrl => _nextPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    return map;
  }

}

class Reviews {
  Reviews({
    String? userImage,
    String? userName,
    int? userId,
    String? type,
    String? feedback,
    String? createdAt,}){
    _userImage = userImage;
    _userName = userName;
    _userId = userId;
    _type = type;
    _feedback = feedback;
    _createdAt = createdAt;
  }

  Reviews.fromJson(dynamic json) {
    _userImage = json['user_image'];
    _userName = json['user_name'];
    _userId = json['user_id'];
    _type = json['type'].toString();
    _feedback = json['feedback'].toString();
    _createdAt = json['created_at'];
  }
  String? _userImage;
  String? _userName;
  int? _userId;
  String? _type;
  String? _feedback;
  String? _createdAt;

  String? get userImage => _userImage;
  String? get userName => _userName;
  int? get userId => _userId;
  String? get type => _type;
  String? get feedback => _feedback;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_image'] = _userImage;
    map['user_name'] = _userName;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['feedback'] = _feedback;
    map['created_at'] = _createdAt;
    return map;
  }

}
