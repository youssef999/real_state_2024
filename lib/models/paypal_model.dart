import 'media_model.dart';
import 'parent/model.dart';

class PayPal extends Model {
  String? name;
  String? email;
  String? password;
  String? confirm;
  Media? avatar;
  String? payId;
  String? describe;
  String? customId;
  PayPal(
      {this.name,
      this.email,
      this.password,
      this.payId,
      this.describe,
      this.customId,
      this.avatar});

  PayPal.fromJson(Map<String, dynamic> json) {
    name = jsonToStr(json, 'full_name');
    email = jsonToStr(json, 'email');
    password = jsonToStr(json, 'password');
    confirm = jsonToStr(json, 'password_confirmation');
    payId = jsonToStr(json, 'paypal_id');
    describe = jsonToStr(json, 'soft_descriptor');
    customId = jsonToStr(json, 'custom_id');
    avatar = jsonToMedia(json, 'avatar');
    super.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = name;
    data['email'] = email;
    data['paypal_id'] = payId;
    data['soft_descriptor'] = describe;
    data['custom_id'] = customId;

    if (avatar != null) {
      data["media"] = [avatar?.toJson()];
    }
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      super == other &&
      other is PayPal &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
      password == other.password &&
      confirm == other.confirm &&
      payId == other.payId &&
      describe == other.describe &&
      customId == other.customId;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirm.hashCode ^
      avatar.hashCode ^
      payId.hashCode ^
      describe.hashCode ^
      customId.hashCode;
}
