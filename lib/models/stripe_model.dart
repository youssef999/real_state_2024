import 'parent/model.dart';

class Stripe extends Model {
  String? id;
  String? name;
  double? balance;
  String? cname;
  String? cnumber;
  String? cvc;
  String? exmonth;
  int? type;
  String? exyear;
  int? paytype;

  Stripe(
      {this.id,
      this.name,
      this.balance,
      this.cname,
      this.cnumber,
      this.cvc,
      this.type,
      this.exmonth,
      this.exyear,
      this.paytype});

  Stripe.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    cname = jsonToStr(json, 'card_number');
    cnumber = jsonToStr(json, 'card_number');
    type = jsonToInt(json, 'type');
    balance = jsonToDouble(json, 'total_balance');
    cvc = jsonToStr(json, 'cvc');
    exmonth = jsonToStr(json, 'exp_month');
    exyear = jsonToStr(json, 'exp_year');
    paytype = jsonToInt(json, 'payment_type');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['id'] = this.id;
    }
    if (name != null) {
      data['name'] = this.name;
    }
    data['type'] = this.type;
    data['card_name'] = this.cname;
    data['card_number'] = this.cnumber;
    data['cvc'] = this.cvc;
    data['exp_month'] = this.exmonth;
    data['exp_year'] = this.exyear;
    data['payment_type'] = this.paytype;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Stripe &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          exmonth == other.exmonth &&
          exyear == other.exyear &&
          cname == other.cname &&
          type == other.type &&
          cnumber == other.cnumber &&
          cvc == other.cvc &&
          paytype == other.paytype;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      cname.hashCode ^
      cname.hashCode ^
      cvc.hashCode ^
      type.hashCode ^
      exmonth.hashCode ^
      exyear.hashCode ^
      paytype.hashCode;
}
