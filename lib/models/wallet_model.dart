import 'dart:math';


import 'package:realstate/models/wallet_transaction_model.dart';

import 'parent/model.dart';

class Wallet extends Model {
  String? id;
  String? name;
  double? balance;
  String? cname;
  String? cnumber;
  String? cvc;
  String? exmonth;
  String? ppEmail;
  int? type;
  String? exyear;
  String? paytype;

  String? amount;
  List<WalletTransaction>? wallet;
  String? fName;
  String? account;
  String? bank;
  String? iban;
  Wallet(
      {this.id,
      this.name,
      this.iban,
      this.bank,
      this.account,
      this.balance,
      this.ppEmail,
      this.cname,
      this.cnumber,
      this.cvc,
      this.wallet,
      this.fName,
      this.type,
      this.exmonth,
      this.exyear,
      this.amount,
      this.paytype});

  Wallet.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = jsonToStr(json, 'name');
    cname = jsonToStr(json, 'card_number');
    cnumber = jsonToStr(json, 'card_number');
    type = jsonToInt(json, 'type');
    balance = jsonToDouble(json, 'total_balance');
    cvc = jsonToStr(json, 'cvc');
    exmonth = jsonToStr(json, 'exp_month');
    exyear = jsonToStr(json, 'exp_year');
    paytype = jsonToStr(json, 'payment_type');
    ppEmail = jsonToStr(json, 'paypal_email');
    amount = jsonToStr(json, 'amount');
    fName = jsonToStr(json, 'full_name');
    account = jsonToStr(json, 'account_number');
    iban = jsonToStr(json, 'iban');
    bank = jsonToStr(json, 'bank_name');
    wallet = jsonToList(
        json, 'total_transaction', (v) => WalletTransaction.fromJson(v));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (balance != null) {
      data['total_balance'] = balance;
    }
    data['total_transaction'] = wallet;
    data['amount'] = amount;
    data['type'] = type;
    data['paypal_email'] = ppEmail;
    data['card_name'] = cname;
    data['card_number'] = cnumber;
    data['cvc'] = cvc;
    data['exp_month'] = exmonth;
    data['exp_year'] = exyear;
    data['payment_type'] = paytype;

    data['account_number'] = account;
    data['iban'] = iban;
    data['bank_name'] = bank;
    data['full_name'] = fName;
    return data;
  }

  String getName() {
    name = name ?? "";
    return name!.substring(name!.length - min(name!.length, 16), name!.length);
  }


  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Wallet &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          exmonth == other.exmonth &&
          exyear == other.exyear &&
          cname == other.cname &&
          ppEmail == other.ppEmail &&
          type == other.type &&
          cnumber == other.cnumber &&
          cvc == other.cvc &&
          paytype == other.paytype &&
          account == other.account &&
          amount == other.amount &&
          fName == other.fName &&
          bank == other.bank &&
          iban == other.iban;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      cname.hashCode ^
      cname.hashCode ^
      ppEmail.hashCode ^
      cvc.hashCode ^
      type.hashCode ^
      exmonth.hashCode ^
      exyear.hashCode ^
      paytype.hashCode ^
      amount.hashCode ^
      account.hashCode ^
      fName.hashCode ^
      bank.hashCode ^
      iban.hashCode;
}
