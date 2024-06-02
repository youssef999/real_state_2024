import 'parent/model.dart';
import 'payment_method_model.dart';

class Payments extends Model {
  String? id;
  String? description;
  double? amount;
  double? usdAmount;
  PaymentMethod? paymentMethod;
  double? totalAmount;
  String? paymentStatus;

  Payments(
      {this.id,
      this.description,
      this.amount,
      this.paymentMethod,
      this.totalAmount,
      this.usdAmount,
      this.paymentStatus});

  Payments.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = jsonToStr(json, 'description');
    amount = jsonToDouble(json, 'payment_amount');
    usdAmount = jsonToDouble(json, 'payment_amount_usd');
    totalAmount = jsonToDouble(json, 'payment_amount_total');
    paymentMethod =
        jsonToObject(json, 'payment_type', (v) => PaymentMethod.fromJson(v));
    paymentStatus = jsonToStr(json, 'payment_status');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['payment_id'] = this.id;
    data['description'] = this.description;
    data['payment_amount'] = this.amount;
    data['payment_amount_usd'] = this.usdAmount;
    data['payment_amount_total'] = this.totalAmount;
    if (paymentMethod != null) {
      data['payment_method_id'] = this.paymentMethod!.id;
    }
    data['payment_status'] = this.paymentStatus;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      super == other &&
      other is Payments &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      totalAmount == other.totalAmount &&
      description == other.description &&
      amount == other.amount &&
      usdAmount == other.usdAmount &&
      paymentMethod == other.paymentMethod &&
      paymentStatus == other.paymentStatus;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      description.hashCode ^
      totalAmount.hashCode ^
      amount.hashCode ^
      usdAmount.hashCode ^
      paymentMethod.hashCode ^
      paymentStatus.hashCode;
}
