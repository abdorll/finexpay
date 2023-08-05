


import '../auth/registration_response_model.dart';

class TradeDetailsResponseModel {
  TradeDetailsResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  TradeDetailsResponseModel.fromJson(dynamic json) {
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
    String? chatFilePath,
    String? userImagePath,
    String? faviconImagePath,
    String? chatPermission,
    String? reviewPermission,
    String? reviewMsz,
    String? buyerHeading,
    String? sellerHeading,
    String? subHeading,
    String? buyerMszOne,
    String? buyerMszTwo,
    String? sellerMszOne,
    String? sellerRemainingMin,
    String? sellerCancelMsz,
    String? sellerDisputeMsz,
    String? buyerRemainingMin,
    String? buyerCancelMsz,
    String? buyerDisputeMsz,
    String? reportedMsz,
    TradeDetails? tradeDetails,
    String? showReviewLink,
  }){
    _chatFilePath = chatFilePath;
    _userImagePath = userImagePath;
    _faviconImagePath = faviconImagePath;
    _chatPermission = chatPermission;
    _reviewPermission = reviewPermission;
    _reviewMsz = reviewMsz;
    _buyerHeading = buyerHeading;
    _sellerHeading = sellerHeading;
    _subHeading = subHeading;
    _buyerMszOne = buyerMszOne;
    _buyerMszTwo = buyerMszTwo;
    _sellerMszOne = sellerMszOne;
    _sellerRemainingMin = sellerRemainingMin;
    _sellerCancelMsz = sellerCancelMsz;
    _sellerDisputeMsz = sellerDisputeMsz;
    _buyerRemainingMin = buyerRemainingMin;
    _buyerCancelMsz = buyerCancelMsz;
    _buyerDisputeMsz = buyerDisputeMsz;
    _reportedMsz = reportedMsz;
    _tradeDetails = tradeDetails;
    _showReviewLink = showReviewLink;
}

  Data.fromJson(dynamic json) {
    _chatFilePath = json['chat_file_path'];
    _userImagePath = json['user_image_path'];
    _faviconImagePath = json['favicon_image_path'];
    _chatPermission = json['chat_permission']!=null?json['chat_permission'].toString():null;
    _reviewPermission = json['review_permission']!=null?json['review_permission'].toString():null;
    _reviewMsz = json['review_msz'];
    _buyerHeading = json['buyer_heading'];
    _sellerHeading = json['seller_heading'];
    _subHeading = json['sub_heading'];
    _buyerMszOne = json['buyer_msz_one'];
    _buyerMszTwo = json['buyer_msz_two'];
    _sellerMszOne = json['seller_msz_one'];
    _sellerRemainingMin = json['seller_remaining_min']!=null?json['seller_remaining_min'].toString():'0';
    _sellerCancelMsz = json['seller_cancel_msz'];
    _sellerDisputeMsz = json['seller_dispute_msz'];
    _buyerRemainingMin = json['buyer_remaining_min'] !=null?json['buyer_remaining_min'].toString():'0';;
    _buyerCancelMsz = json['buyer_cancel_msz'];
    _buyerDisputeMsz = json['buyer_dispute_msz'];
    _reportedMsz = json['reported_msz'];
    _tradeDetails = json['trade_details'] != null ? TradeDetails.fromJson(json['trade_details']) : null;
    _showReviewLink = json['show_reviews_link'] != null ? json['show_reviews_link'].toString() : '-1';
  }

  String? _chatFilePath;
  String? _userImagePath;
  String? _faviconImagePath;
  String? _chatPermission;
  String? _reviewPermission;
  String? _reviewMsz;
  String? _buyerHeading;
  String? _sellerHeading;
  String? _subHeading;
  String? _buyerMszOne;
  String? _buyerMszTwo;
  String? _sellerMszOne;
  String? _sellerRemainingMin;
  String? _sellerCancelMsz;
  String? _sellerDisputeMsz;
  String? _buyerRemainingMin;
  String? _buyerCancelMsz;
  String? _buyerDisputeMsz;
  String? _reportedMsz;
  TradeDetails? _tradeDetails;
  String? _showReviewLink;

  String? get chatFilePath => _chatFilePath;
  String? get userImagePath => _userImagePath;
  String? get faviconImagePath => _faviconImagePath;
  String? get chatPermission => _chatPermission;
  String? get reviewPermission => _reviewPermission;
  String? get buyerHeading => _buyerHeading;
  String? get sellerHeading => _sellerHeading;
  String? get subHeading => _subHeading;
  String? get buyerMszOne => _buyerMszOne;
  String? get buyerMszTwo => _buyerMszTwo;
  String? get sellerMszOne => _sellerMszOne;
  String? get sellerRemainingMin => _sellerRemainingMin;
  String? get sellerCancelMsz => _sellerCancelMsz;
  String? get sellerDisputeMsz => _sellerDisputeMsz;
  String? get buyerRemainingMin => _buyerRemainingMin;
  String? get buyerCancelMsz => _buyerCancelMsz;
  String? get buyerDisputeMsz => _buyerDisputeMsz;
  TradeDetails? get tradeDetails => _tradeDetails;
  String? get reviewMsz => _reviewMsz;
  String? get reportedMsz =>  _reportedMsz;
  String? get showReviewLink => _showReviewLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chat_file_path'] = _chatFilePath;
    map['user_image_path'] = _userImagePath;
    map['favicon_image_path'] = _faviconImagePath;
    map['chat_permission'] = _chatPermission;
    map['review_permission'] = _reviewPermission;
    map['review_msz'] = _reviewMsz;
    map['buyer_heading'] = _buyerHeading;
    map['seller_heading'] = _sellerHeading;
    map['sub_heading'] = _subHeading;
    map['buyer_msz_one'] = _buyerMszOne;
    map['buyer_msz_two'] = _buyerMszTwo;
    map['seller_msz_one'] = _sellerMszOne;
    map['seller_remaining_min'] = _sellerRemainingMin;
    map['seller_cancel_msz'] = _sellerCancelMsz;
    map['seller_dispute_msz'] = _sellerDisputeMsz;
    map['buyer_remaining_min'] = _buyerRemainingMin;
    map['buyer_cancel_msz'] = _buyerCancelMsz;
    map['buyer_dispute_msz'] = _buyerDisputeMsz;
    map['reported_msz'] = _reportedMsz;
    map['show_review_link'] = _showReviewLink;
    if (_tradeDetails != null) {
      map['trade_details'] = _tradeDetails?.toJson();
    }

    return map;
  }

}

class TradeDetails {
  TradeDetails({
      int? id, 
      String? uid, 
      String? advertisementId, 
      String? sellerId, 
      String? buyerId, 
      String? amount, 
      String? cryptoAmount, 
      String? tradeCharge, 
      String? cryptoId, 
      String? fiatGatewayId, 
      String? fiatId, 
      String? exchangeRate, 
      String? window, 
      String? status, 
      String? reviewed,
      String? details,
      String? paidAt, 
      String? completedAt, 
      String? createdAt, 
      String? updatedAt, 
      List<Chats>? chats, 
      Buyer? buyer, 
      Seller? seller, 
      Crypto? crypto, 
      Fiat? fiat, 
      FiatGateway? fiatGateway, 
      Advertisement? advertisement,}){
    _id = id;
    _uid = uid;
    _advertisementId = advertisementId;
    _sellerId = sellerId;
    _buyerId = buyerId;
    _amount = amount;
    _cryptoAmount = cryptoAmount;
    _tradeCharge = tradeCharge;
    _cryptoId = cryptoId;
    _fiatGatewayId = fiatGatewayId;
    _fiatId = fiatId;
    _exchangeRate = exchangeRate;
    _window = window;
    _status = status;
    _reviewed = reviewed;
    _details = details;
    _paidAt = paidAt;
    _completedAt = completedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _chats = chats;
    _buyer = buyer;
    _seller = seller;
    _crypto = crypto;
    _fiat = fiat;
    _fiatGateway = fiatGateway;
    _advertisement = advertisement;
}

  TradeDetails.fromJson(dynamic json) {
    _id = json['id'];
    _uid = json['uid'].toString();
    _advertisementId  = json['advertisement_id']!=null?json['advertisement_id'].toString():null;
    _sellerId = json['seller_id'].toString();
    _buyerId = json['buyer_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():null;
    _cryptoAmount  = json['crypto_amount']!=null?json['crypto_amount'].toString():null;
    _tradeCharge = json['trade_charge'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _fiatGatewayId = json['fiat_gateway_id'].toString();
    _fiatId = json['fiat_id'].toString();
    _exchangeRate = json['exchange_rate'];
    _window  = json['window']!=null? json['window'].toString():null;
    _status = json['status']!=null? json['status'].toString():null;
    _reviewed = json['reviewed']!=null? json['reviewed'].toString():null;
    _details = json['details'];
    _paidAt = json['paid_at'];
    _completedAt = json['completed_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['chats'] != null) {
      _chats = [];
      json['chats'].forEach((v) {
        _chats?.add(Chats.fromJson(v));
      });
    }
    _buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _fiat = json['fiat'] != null ? Fiat.fromJson(json['fiat']) : null;
    _fiatGateway = json['fiat_gateway'] != null ? FiatGateway.fromJson(json['fiat_gateway']) : null;
    _advertisement = json['advertisement'] != null ? Advertisement.fromJson(json['advertisement']) : null;
  }
  int? _id;
  String? _uid;
  String? _advertisementId;
  String? _sellerId;
  String? _buyerId;
  String? _amount;
  String? _cryptoAmount;
  String? _tradeCharge;
  String? _cryptoId;
  String? _fiatGatewayId;
  String? _fiatId;
  String? _exchangeRate;
  String? _window;
  String? _status;
  String? _reviewed;
  String? _details;
  String? _paidAt;
  String? _completedAt;
  String? _createdAt;
  String? _updatedAt;
  List<Chats>? _chats;
  Buyer? _buyer;
  Seller? _seller;
  Crypto? _crypto;
  Fiat? _fiat;
  FiatGateway? _fiatGateway;
  Advertisement? _advertisement;

  int? get id => _id;
  String? get uid => _uid;
  String? get advertisementId => _advertisementId;
  String? get sellerId => _sellerId;
  String? get buyerId => _buyerId;
  String? get amount => _amount;
  String? get cryptoAmount => _cryptoAmount;
  String? get tradeCharge => _tradeCharge;
  String? get cryptoId => _cryptoId;
  String? get fiatGatewayId => _fiatGatewayId;
  String? get fiatId => _fiatId;
  String? get exchangeRate => _exchangeRate;
  String? get window => _window;
  String? get status => _status;
  String? get reviewed => _reviewed;
  String? get details => _details;
  String? get paidAt => _paidAt;
  String? get completedAt => _completedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Chats>? get chats => _chats;
  Buyer? get buyer => _buyer;
  Seller? get seller => _seller;
  Crypto? get crypto => _crypto;
  Fiat? get fiat => _fiat;
  FiatGateway? get fiatGateway => _fiatGateway;
  Advertisement? get advertisement => _advertisement;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uid'] = _uid;
    map['advertisement_id'] = _advertisementId;
    map['seller_id'] = _sellerId;
    map['buyer_id'] = _buyerId;
    map['amount'] = _amount;
    map['crypto_amount'] = _cryptoAmount;
    map['trade_charge'] = _tradeCharge;
    map['crypto_id'] = _cryptoId;
    map['fiat_gateway_id'] = _fiatGatewayId;
    map['fiat_id'] = _fiatId;
    map['exchange_rate'] = _exchangeRate;
    map['window'] = _window;
    map['status'] = _status;
    map['details'] = _details;
    map['paid_at'] = _paidAt;
    map['completed_at'] = _completedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_chats != null) {
      map['chats'] = _chats?.map((v) => v.toJson()).toList();
    }
    if (_buyer != null) {
      map['buyer'] = _buyer?.toJson();
    }
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    if (_fiat != null) {
      map['fiat'] = _fiat?.toJson();
    }
    if (_fiatGateway != null) {
      map['fiat_gateway'] = _fiatGateway?.toJson();
    }
    if (_advertisement != null) {
      map['advertisement'] = _advertisement?.toJson();
    }
    return map;
  }

}

class Advertisement {
  Advertisement({
      int? id, 
      String? userId, 
      String? type, 
      String? cryptoId, 
      String? fiatGatewayId, 
      String? fiatId, 
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
      Crypto? crypto,}){
    _id = id;
    _userId = userId;
    _type = type;
    _cryptoId = cryptoId;
    _fiatGatewayId = fiatGatewayId;
    _fiatId = fiatId;
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
    _crypto = crypto;
}

  Advertisement.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _type = json['type'].toString();
    _cryptoId = json['crypto_currency_id'].toString();
    _fiatGatewayId = json['fiat_gateway_id'].toString();
    _fiatId = json['fiat_id'].toString();
    _margin = json['margin']!=null?json['margin'].toString():null;
    _fixedPrice = json['fixed_price']!=null?json['fixed_price'].toString():null;
    _window  = json['window']!=null? json['window'].toString():null;
    _min = json['min'];
    _max = json['max'];
    _details = json['details'];
    _terms = json['terms'];
    _status = json['status']!=null? json['status'].toString():null;
    _completedTrade = json['completed_trade'].toString();
   
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
  }
  int? _id;
  String? _userId;
  String? _type;
  String? _cryptoId;
  String? _fiatGatewayId;
  String? _fiatId;
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
  Crypto? _crypto;

  int? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get cryptoId => _cryptoId;
  String? get fiatGatewayId => _fiatGatewayId;
  String? get fiatId => _fiatId;
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
  Crypto? get crypto => _crypto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['crypto_id'] = _cryptoId;
    map['fiat_gateway_id'] = _fiatGatewayId;
    map['fiat_id'] = _fiatId;
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
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
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

class FiatGateway {
  FiatGateway({
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

  FiatGateway.fromJson(dynamic json) {
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


class Seller {
  Seller({
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

  Seller.fromJson(dynamic json) {
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

class Buyer {
  Buyer({
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
      dynamic verCode, 
      dynamic verCodeSendAt, 
      String? ts, 
      String? tv, 
      String? tsc, 
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

  Buyer.fromJson(dynamic json) {
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
  
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
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


class Chats {
  Chats({
      int? id, 
      String? tradeRequestId, 
      String? userId, 
      dynamic admin, 
      String? message, 
      dynamic file, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _tradeRequestId = tradeRequestId;
    _userId = userId;
    _admin = admin;
    _message = message;
    _file = file;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Chats.fromJson(dynamic json) {
    _id = json['id'];
    _tradeRequestId = json['trade_request_id'];
    _userId = json['user_id'].toString();
    _admin = json['admin'];
    _message = json['message'];
    _file = json['file'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _tradeRequestId;
  String? _userId;
  dynamic _admin;
  String? _message;
  dynamic _file;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get tradeRequestId => _tradeRequestId;
  String? get userId => _userId;
  dynamic get admin => _admin;
  String? get message => _message;
  dynamic get file => _file;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['trade_request_id'] = _tradeRequestId;
    map['user_id'] = _userId;
    map['admin'] = _admin;
    map['message'] = _message;
    map['file'] = _file;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}


class Review {
  Review({
    int? id,
    String? advertisementId,
    String? tradeId,
    String? userId,
    String? toId,
    String? type,
    String? feedback,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _advertisementId = advertisementId;
    _tradeId = tradeId;
    _userId = userId;
    _toId = toId;
    _type = type;
    _feedback = feedback;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Review.fromJson(dynamic json) {
    _id = json['id'];
    _advertisementId = json['advertisement_id'].toString();
    _tradeId = json['trade_id'].toString();
    _userId = json['user_id'].toString();
    _toId = json['to_id'].toString();
    _type = json['type'].toString();
    _feedback = json['feedback'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _advertisementId;
  String? _tradeId;
  String? _userId;
  String? _toId;
  String? _type;
  String? _feedback;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get advertisementId => _advertisementId;
  String? get tradeId => _tradeId;
  String? get userId => _userId;
  String? get toId => _toId;
  String? get type => _type;
  String? get feedback => _feedback;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['advertisement_id'] = _advertisementId;
    map['trade_id'] = _tradeId;
    map['user_id'] = _userId;
    map['to_id'] = _toId;
    map['type'] = _type;
    map['feedback'] = _feedback;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
