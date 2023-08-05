
class NewAdvertisementBodyModel{
  
  final String trxType;
  final String cryptoId;
  final String fiatGatewayId;
  final String fiatId;
  final String margin;
  final String fixedPrice;
  final String window;
  final String min;
  final String max;
  final String details;
  final String terms;
  final String priceType;


  NewAdvertisementBodyModel({
      required this.trxType,
      required this.cryptoId,
      required this.fiatGatewayId,
      required this.fiatId,
      this.margin='-1',
      this.fixedPrice='-1',
    required this.priceType,
      required this.window,
      required this.min,
      required this.max,
      required this.details,
      required this.terms});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type']=trxType;
    map['crypto_id']= cryptoId;
    map['fiat_gateway_id']=fiatGatewayId;
    map['fiat_id']= fiatId;
    if(margin=='-1'){
      map['fixed_price']=fixedPrice;
    }else{
      map['margin']=margin;
    }
    map['window']= window;
    map['min']= min;
    map['max']= max;
    map['price_type']= priceType;
    map['details']= details;
    map['terms']= terms;
   return map;
  }

  factory NewAdvertisementBodyModel.fromMap(Map<String, dynamic> map) {

    return NewAdvertisementBodyModel(
      trxType: map['trxType'] as String,
      cryptoId: map['cryptoId'] as String,
      fiatGatewayId: map['fiatGatewayId'] as String,
      fiatId: map['fiatId'] as String,
      margin: map['margin'] as String,
      fixedPrice: map['fixedPrice'] as String,
      window: map['window'] as String,
      min: map['min'] as String,
      max: map['max'] as String,
      priceType: map['price_type'] as String,
      details: map['details'] as String,
      terms: map['terms'] as String,
    );

  }
}