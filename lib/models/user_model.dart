import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:realstate/models/address_model.dart';

import 'parent/model.dart';

class Users extends Model {
  String? userId;
  String? name;
  String? email;
  String? verify;
  String? license;
  String? password;
  String? confirm;
  String? image;
  String? apiToken;
  String? deviceToken;
  String? phoneNumber;
  Address? addressBooking;
  String? roleId;
  bool? verifiedPhone;
  String? verificationId;
  int? genderId;
  String? token;
  int? carType;
  String? address;
  String? bio;
  bool? auth;

  Users(
      {this.name,
      this.email,
      this.password,
      this.userId,
      this.apiToken,
      this.addressBooking,
      this.verify,
      this.token,
      this.confirm,
      this.deviceToken,
      this.carType,
      this.genderId,
      this.roleId,
      this.license,
      this.phoneNumber,
      this.verifiedPhone,
      this.verificationId,
      this.address,
      this.bio,
      this.image});

  Users.fromJson(Map<String, dynamic> json) {
    name = jsonToStr(json, 'user_name');
    email = jsonToStr(json, 'user_email');
    apiToken = jsonToStr(json, 'api_token');
    deviceToken = jsonToStr(json, 'fcsToken');
    token = jsonToStr(json, 'token');
    genderId = jsonToInt(json, 'gender');
    userId = jsonToStr(json, 'user_id');
    carType = jsonToInt(json, 'car_id');
    verify = jsonToStr(json, 'verification_code');
    phoneNumber = jsonToStr(json, 'phone');
    password = jsonToStr(json, 'pass');
    confirm = jsonToStr(json, 'password_confirmation');
    verifiedPhone = jsonToBool(json, 'phone_verified_at');
    image = jsonToStr(json, 'image');
    roleId = jsonToStr(json, 'roleId');
    addressBooking =
        jsonToObject(json, 'address_user', (value) => Address.fromJson(value));
    auth = jsonToBool(json, 'auth');
    try {
      address = json['user_information']['address'];
    } catch (e) {
      address = jsonToStr(json, 'address');
    }
    try {
      bio = json['user_information']['short_biography'];
    } catch (e) {
      bio = jsonToStr(json, 'short_biography');
    }

    super.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = name;
    data['address_user'] = addressBooking;
    data['user_email'] = email;
    data['token'] = token;
    data['user_id'] = userId;
    if (password != null && password != '') {
      data['pass'] = password;
    }
    if (confirm == password && password != null && password != '') {
      data['password_confirmation'] = confirm;
    }
    data['verification_code'] = verify;
    data['api_token'] = apiToken;
    if (deviceToken != null) {
      data["fcsToken"] = deviceToken;
    }
    data['car_license'] = license;
    if (verifiedPhone != null && verifiedPhone!) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["roleId"] = roleId;
    data['gender'] = genderId;
    data['car_id'] = carType;
    data['phone'] = phoneNumber;
    data["short_biography"] = bio;

    if (image != null) {
      data["media"] = image;
    }
    data['auth'] = auth;
    return data;
  }

  PhoneNumber getPhoneNumber() {
    if (phoneNumber?.isEmpty == false) {
      try {
        phoneNumber = phoneNumber!.replaceAll(' ', '');
        String dialCode1 = phoneNumber!.substring(1, 2);
        String dialCode2 = phoneNumber!.substring(1, 3);
        String dialCode3 = phoneNumber!.substring(1, 4);
        for (int i = 0; i < countries.length; i++) {
          if (countries[i].dialCode == dialCode1) {
            return PhoneNumber(
                countryISOCode: countries[i].code,
                countryCode: dialCode1,
                number: phoneNumber!.substring(2));
          } else if (countries[i].dialCode == dialCode2) {
            return PhoneNumber(
                countryISOCode: countries[i].code,
                countryCode: dialCode2,
                number: phoneNumber!.substring(3));
          } else if (countries[i].dialCode == dialCode3) {
            return PhoneNumber(
                countryISOCode: countries[i].code,
                countryCode: dialCode3,
                number: phoneNumber!.substring(4));
          }
        }
      } catch (e) {
        print(e);
      }
    }
    return PhoneNumber(countryISOCode: "AE", countryCode: '1', number: '');
  }

  @override
  // ignore: non_nullable_equals_parameter
  bool operator ==(dynamic other) =>
      super == other &&
      other is Users &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
       token == other.token &&
      genderId == other.genderId &&
      carType == other.carType &&
      password == other.password &&
      userId == other.userId &&
      verify == other.verify &&
      confirm == other.confirm &&
      image == other.image &&
      apiToken == other.apiToken &&
      license == other.license &&
      addressBooking == other.addressBooking &&
      deviceToken == other.deviceToken &&
      roleId == other.roleId &&
      phoneNumber == other.phoneNumber &&
      verifiedPhone == other.verifiedPhone &&
      verificationId == other.verificationId &&
      address == other.address &&
      bio == other.bio &&
      auth == other.auth;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      userId.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirm.hashCode ^
      image.hashCode ^
      roleId.hashCode ^
      apiToken.hashCode ^
      genderId.hashCode ^
      carType.hashCode ^
      addressBooking.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verify.hashCode ^
      token.hashCode ^
      verifiedPhone.hashCode ^
      license.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      bio.hashCode ^
      auth.hashCode;
}
