import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'parent/model.dart';

class Address extends Model {
  late String? id;
  String? description;
  String? address;
  late double? latitude;
  late double? longitude;
  bool? isDefault;
  String? userId;

  Address(
      {this.id,
      this.description,
      this.address,
      this.latitude,
      this.longitude,
      this.isDefault,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = jsonToStr(json, 'description');
    address = jsonToStr(json, 'address');
    latitude = jsonToDouble(json, 'latitude', decimal: 10);
    longitude = jsonToDouble(json, 'longitude', decimal: 10);
    isDefault = jsonToBool(json, 'default');
    userId = jsonToStr(json, 'user_id');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['default'] = this.isDefault;
    if (this.userId != null) {
      data['user_id'] = this.userId;
    }
    return data;
  }

  bool isUnknown() {
    return latitude == null || longitude == null;
  }

  bool hasDescription() {
    if (description != null && description!.isNotEmpty) return true;
    return false;
  }

  LatLng getLatLng() {
    if (this.isUnknown()) {
      return LatLng(38.806103, 52.4964453);
    } else {
      return LatLng(this.latitude!, this.longitude!);
    }
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Address &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          address == other.address &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          userId == other.userId &&
          isDefault == other.isDefault;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      address.hashCode ^
      description.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      userId.hashCode ^
      isDefault.hashCode;
}
