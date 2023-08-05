
class PaymentModel{
  String? _trxId;
  String? _planName;
  String? _gateway;
  double? _amount;
  String? _status;
  String? _time;
  double? _charge;
  double? _conversionRate;
  double? _payableAmount;

        PaymentModel({
          String? trxId,
          String? planName,
          String? gateway,
          double? amount,
          String? status,
          String? time,
          double? charge,
          double? conversionRate,
          double? payableAmount
      }){
          _trxId=trxId;
          _planName=planName;
          _gateway=gateway;
          _amount=amount;
          _status=status;
          _time=time;
          _charge=charge;
          _conversionRate=conversionRate;
          _payableAmount=payableAmount;
        }

        PaymentModel.fromJson(dynamic json){

        }

}