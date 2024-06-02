import 'dart:math';

import 'package:get/get.dart';

import 'media_model.dart';
import 'parent/model.dart';
import 'wallet_model.dart';

class PaymentMethod extends Model {
  String? id;
  String? name;
  String? description;
  Media? logo;
  String? route;
  int? order;
  bool? isDefault;
  Wallet? wallet;

  PaymentMethod(
      {this.id,
      this.name,
      this.description,
      this.route,
      this.logo,
      this.wallet,
      this.isDefault = false});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    route = jsonToStr(json, 'route');
    logo = jsonToMedia(json, 'logo');
    order = jsonToInt(json, 'order');
    isDefault = jsonToBool(json, 'default');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  String getName() {
    name = name ?? "Not Paid".tr;
    return name!.substring(name!.length - min(name!.length, 10), name!.length);
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          route == other.route &&
          order == other.order &&
          wallet == other.wallet;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      route.hashCode ^
      order.hashCode ^
      wallet.hashCode;
}
