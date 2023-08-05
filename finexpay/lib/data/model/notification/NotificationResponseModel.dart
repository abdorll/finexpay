

import '../auth/registration_response_model.dart';

class NotificationResponseModel {
  NotificationResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  NotificationResponseModel.fromJson(dynamic json) {
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
      Notifications? notifications,}){
    _notifications = notifications;
}

  MainData.fromJson(dynamic json) {
    _notifications = json['notifications'] != null ? Notifications.fromJson(json['notifications']) : null;
  }
  Notifications? _notifications;

  Notifications? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_notifications != null) {
      map['notifications'] = _notifications?.toJson();
    }
    return map;
  }

}

class Notifications {
  Notifications({
       
      List<Data>? data, 
      
       
      List<Links>? links, 
      dynamic nextPageUrl, 
      }){
   
    _data = data;
    
    
    _links = links;
    _nextPageUrl = nextPageUrl;
    
    
}

  Notifications.fromJson(dynamic json) {
    
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
    String? title,
    String? userId,
    String? readStatus,
    String? remark,
    String? clickValue,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _title = title;
    _userId = userId;
    _readStatus = readStatus;
    _remark = remark;
    _clickValue = clickValue;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _userId = json['user_id'].toString();
    _readStatus = json['read_status'].toString();
    _remark = json['remark'];
    _clickValue = json['click_value'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _title;
  String? _userId;
  String? _readStatus;
  String? _remark;
  String? _clickValue;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get title => _title;
  String? get userId => _userId;
  String? get readStatus => _readStatus;
  String? get remark => _remark;
  String? get clickValue => _clickValue;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['user_id'] = _userId;
    map['read_status'] = _readStatus;
    map['remark'] = _remark;
    map['click_value'] = _clickValue;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

