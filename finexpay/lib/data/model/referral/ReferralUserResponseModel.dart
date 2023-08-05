
import '../auth/registration_response_model.dart';

class ReferralUserResponseModel {
  ReferralUserResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  ReferralUserResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
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
      List<ReferralUsers>? referralUsers,}){
    _referralUsers = referralUsers;
}

  Data.fromJson(dynamic json) {
    if (json['referral_users'] != null) {
      _referralUsers = [];
      json['referral_users'].forEach((v) {
        _referralUsers?.add(ReferralUsers.fromJson(v));
      });
    }
  }
  List<ReferralUsers>? _referralUsers;

  List<ReferralUsers>? get referralUsers => _referralUsers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_referralUsers != null) {
      map['referral_users'] = _referralUsers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ReferralUsers {
  ReferralUsers({
      int? id, 
      String? username, 
      String? image,
      String? level,}){
    _id = id;
    _username = username;
    _level = level;
    _image = image;
}

  ReferralUsers.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _level = json['level'].toString();
    _image = json['image'];
  }
  int? _id;
  String? _username;
  String? _level;
  String? _image;

  int? get id => _id;
  String? get username => _username;
  String? get level => _level;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['level'] = _level;
    map['image'] = _image;
    return map;
  }

}

