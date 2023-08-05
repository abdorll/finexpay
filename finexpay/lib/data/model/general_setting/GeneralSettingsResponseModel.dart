import '../auth/registration_response_model.dart';

class GeneralSettingsResponseModel {
  GeneralSettingsResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  GeneralSettingsResponseModel.fromJson(dynamic json) {
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
      GeneralSetting? generalSetting,}){
    _generalSetting = generalSetting;
}

  Data.fromJson(dynamic json) {
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;

  GeneralSetting? get generalSetting => _generalSetting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }

}

class GeneralSetting {
  GeneralSetting({
      int? id, 
      String? siteName, 
      String? curText, 
      String? curSym, 
      String? emailFrom, 
      String? smsBody, 
      String? smsFrom, 
      String? baseColor, 
      String? secondaryColor, 
      MailConfig? mailConfig, 
      GlobalShortcodes? globalShortcodes,
      String? forceSsl,
      String? securePassword,
      String? agree,
      String? registration,
      String? activeTemplate, 
      dynamic sysVersion, 
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _siteName = siteName;
    _curText = curText;
    _curSym = curSym;
    _emailFrom = emailFrom;
    _smsBody = smsBody;
    _smsFrom = smsFrom;
    _baseColor = baseColor;
    _secondaryColor = secondaryColor;
    _mailConfig = mailConfig;
    _globalShortcodes = globalShortcodes;
    _securePassword = securePassword;
    _agree = agree;
    _registration = registration;
    _activeTemplate = activeTemplate;
    _sysVersion = sysVersion;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'];
    _curText = json['cur_text'];
    _curSym = json['cur_sym'];
    _emailFrom = json['email_from'];
    _smsBody = json['sms_body'];
    _smsFrom = json['sms_from'];
    _baseColor = json['base_color'];
    _secondaryColor = json['secondary_color'];
    _mailConfig = json['mail_config'] != null ? MailConfig.fromJson(json['mail_config']) : null;
    _globalShortcodes = json['global_shortcodes'] != null ? GlobalShortcodes.fromJson(json['global_shortcodes']) : null;
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _registration = json['registration'].toString();
    _activeTemplate = json['active_template'];
    _sysVersion = json['sys_version'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _siteName;
  String? _curText;
  String? _curSym;
  String? _emailFrom;
  String? _smsBody;
  String? _smsFrom;
  String? _baseColor;
  String? _secondaryColor;
  MailConfig? _mailConfig;
  GlobalShortcodes? _globalShortcodes;
  String? _securePassword;
  String? _agree;
  String? _registration;
  String? _activeTemplate;
  dynamic _sysVersion;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get siteName => _siteName;
  String? get curText => _curText;
  String? get curSym => _curSym;
  String? get emailFrom => _emailFrom;
  String? get smsBody => _smsBody;
  String? get smsFrom => _smsFrom;
  String? get baseColor => _baseColor;
  String? get secondaryColor => _secondaryColor;
  MailConfig? get mailConfig => _mailConfig;
  GlobalShortcodes? get globalShortcodes => _globalShortcodes;
  String? get securePassword => _securePassword;
  String? get agree => _agree;
  String? get registration => _registration;
  String? get activeTemplate => _activeTemplate;
  dynamic get sysVersion => _sysVersion;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['email_from'] = _emailFrom;
    map['sms_body'] = _smsBody;
    map['sms_from'] = _smsFrom;
    map['base_color'] = _baseColor;
    map['secondary_color'] = _secondaryColor;
    if (_mailConfig != null) {
      map['mail_config'] = _mailConfig?.toJson();
    }
    if (_globalShortcodes != null) {
      map['global_shortcodes'] = _globalShortcodes?.toJson();
    }
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['registration'] = _registration;
    map['active_template'] = _activeTemplate;
    map['sys_version'] = _sysVersion;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class GlobalShortcodes {
  GlobalShortcodes({
      String? siteName, 
      String? siteCurrency, 
      String? currencySymbol,}){
    _siteName = siteName;
    _siteCurrency = siteCurrency;
    _currencySymbol = currencySymbol;
}

  GlobalShortcodes.fromJson(dynamic json) {
    _siteName = json['site_name'];
    _siteCurrency = json['site_currency'];
    _currencySymbol = json['currency_symbol'];
  }
  String? _siteName;
  String? _siteCurrency;
  String? _currencySymbol;

  String? get siteName => _siteName;
  String? get siteCurrency => _siteCurrency;
  String? get currencySymbol => _currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['site_name'] = _siteName;
    map['site_currency'] = _siteCurrency;
    map['currency_symbol'] = _currencySymbol;
    return map;
  }

}

class MailConfig {
  MailConfig({
      String? name,}){
    _name = name;
}

  MailConfig.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}

