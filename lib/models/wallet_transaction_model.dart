import 'dart:math';

import 'parent/model.dart';
import 'user_model.dart';

enum TransactionActions { CREDIT, DEBIT }

class WalletTransaction extends Model {
  String? id;
  double? amount;
  String? description;
  TransactionActions? action;
  DateTime? dateTime;
  Users? user;

  WalletTransaction(
      {this.id, this.amount, this.description, this.action, this.user});

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = jsonToStr(json, 'description');
    amount = jsonToDouble(json, 'amount');
    user = jsonToObject(json, 'user', (value) => Users.fromJson(value));
    dateTime = jsonToDate(json, 'created_at', defaultValue: null);
    if (json['action'] == 'credit') {
      action = TransactionActions.CREDIT;
    } else if (json['action'] == 'debit') {
      action = TransactionActions.DEBIT;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['action'] = this.action;
    data['user'] = this.user;
    return data;
  }

  String getDescription() {
    description = description ?? "";
    return description!.substring(
        description!.length - min(description!.length, 20),
        description!.length);
  }
}
