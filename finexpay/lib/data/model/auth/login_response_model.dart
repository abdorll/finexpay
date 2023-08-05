

class LoginResponseModel {
  LoginResponseModel({
    String? status,
    Message? message,
    Data? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Message? _message;
  Data? _data;

  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    User? user,
    String? accessToken,
    String? tokenType,}){
    _user = user;
    _accessToken = accessToken;
    _tokenType = tokenType;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
  }
  User? _user;
  String? _accessToken;
  String? _tokenType;

  User? get user => _user;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
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
    String? balance,
    String? image,
    Address? address,
    String? status,
    dynamic kycData,
    String? kv,
    String? ev,
    String? sv,
    String? tv,
    String? profileComplete,
    String? verCodeSendAt,
    dynamic tsc,
    dynamic sessionData,
    dynamic banReason,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _refBy = refBy;
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _kycData = kycData;
    _kv = kv;
    _ev = ev;
    _sv = sv;
    _tv = tv;
    _profileComplete = profileComplete;
    _verCodeSendAt = verCodeSendAt;
    _tsc = tsc;
    _sessionData = sessionData;
    _banReason = banReason;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'].toString();
    _lastname = json['lastname'].toString();
    _username = json['username'].toString();
    _email = json['email'].toString();
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _refBy = json['ref_by'].toString();
    _balance = json['balance'].toString();
    _image = json['image'].toString();
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status'].toString();
    _kycData = json['kyc_data'].toString();
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    _tv = json['tv'].toString();
    _profileComplete = json['profile_complete'].toString();
    _verCodeSendAt = json['ver_code_send_at'].toString();
    _tsc = json['tsc'].toString();
    _sessionData = json['session_data'].toString();
    _banReason = json['ban_reason'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
  }
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _refBy;
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  dynamic _kycData;
  String? _kv;
  String? _ev;
  String? _sv;
  String? _tv;
  String? _profileComplete;
  String? _verCodeSendAt;
  dynamic _tsc;
  dynamic _sessionData;
  dynamic _banReason;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get refBy => _refBy;
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  dynamic get kycData => _kycData;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get sv => _sv;
  String? get tv => _tv;
  String? get profileComplete => _profileComplete;
  String? get verCodeSendAt => _verCodeSendAt;
  dynamic get tsc => _tsc;
  dynamic get sessionData => _sessionData;
  dynamic get banReason => _banReason;
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
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kyc_data'] = _kycData;
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['tv'] = _tv;
    map['profile_complete'] = _profileComplete;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['tsc'] = _tsc;
    map['session_data'] = _sessionData;
    map['ban_reason'] = _banReason;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Address {
  Address({
    String? address,
    String? state,
    String? zip,
    String? country,
    String? city,}){
    _address = address;
    _state = state;
    _zip = zip;
    _country = country;
    _city = city;
  }

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _city = json['city'];
  }
  String? _address;
  String? _state;
  String? _zip;
  String? _country;
  String? _city;

  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['city'] = _city;
    return map;
  }

}

class Message {
  Message({
    List<String>? success,List<String>?error}){
    _success = success;
    _error=error;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ?json['success'].cast<String>():null;
    _error = json['error'] != null ? json['error'].cast<String>() :[];
  }
  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    return map;
  }

}

