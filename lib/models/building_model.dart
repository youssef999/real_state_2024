import 'package:realstate/models/parent/model.dart';

class Building extends Model {
  @override
  String? id;
  String? image;
  String? name;
  String? item;
  String? description;
  String? cat;
  String? type;
  String? price;
  String? locationCountry;
  String? nameUser;
  String? emailUser;
  String? imageUser;
  String? locationArea;
  String? address;
  String? buildNum;
  String? buildingSteps;
  String? toilet;
  String? rentMonthly;
  String? rentTime;
  String? bankSafe;
  String? lettingTime;
  String? space;
  String? rooms;

  Building(
      {this.id,
      this.image,
      this.nameUser,
      this.emailUser,
      this.imageUser,
      this.type,
      this.cat,
      this.locationCountry,
      this.locationArea,
      this.address,
      this.buildNum,
      this.item,
      this.buildingSteps,
      this.toilet,
      this.rentMonthly,
      this.rentTime,
      this.bankSafe,
      this.lettingTime,
      this.name,
      this.description,
      this.price,
      this.space,
      this.rooms});

  Building.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    id = jsonToStr(json, 'id');
    nameUser = jsonToStr(json, 'user_name');
    emailUser = jsonToStr(json, 'user_email');
    name = jsonToStr(json, 'name');
    item = jsonToStr(json, 'item');
    description = jsonToStr(json, 'description');
    price = jsonToStr(json, 'price');
    image = jsonToStr(json, 'image');
    imageUser = jsonToStr(json, 'image_user');

    locationCountry = jsonToStr(json, 'location_country');
    locationArea = jsonToStr(json, 'location_area');
    address = jsonToStr(json, 'address');
    buildNum = jsonToStr(json, 'building_number');
    buildingSteps = jsonToStr(json, 'floor_number');
    toilet = jsonToStr(json, 'toilet_number');
    rentMonthly = jsonToStr(json, 'monthly_rent');
    rentTime = jsonToStr(json, 'rent_time');
    bankSafe = jsonToStr(json, 'bank_security');
    lettingTime = jsonToStr(json, 'availability_time');
    type = jsonToStr(json, 'type');
    cat = jsonToStr(json, 'cat');
    rooms = jsonToStr(json, 'rooms_number');
    space = jsonToStr(json, 'area');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['cat'] = cat;
    data['item'] = item;
    data['type'] = type;
    data['description'] = description;
    data['price'] = price;
    data['image_user'] = imageUser;
    data['location_country'] = locationCountry;
    data['location_area'] = locationArea;
    data['address'] = address;
    data['building_number'] = buildNum;
    data['floor_number'] = buildingSteps;
    data['toilet_number'] = toilet;
    data['monthly_rent'] = rentMonthly;
    data['rent_time'] = rentTime;
    data['bank_security'] = bankSafe;
    data['user_name'] = nameUser;
    data['user_email'] = emailUser;
    data['availability_time'] = lettingTime;
    data['images'] = image;
    data['rooms_number'] = rooms;
    data['area'] = space;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Building &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameUser == other.nameUser &&
          emailUser == other.emailUser &&
          image == other.image &&
          locationCountry == other.locationCountry &&
          locationArea == other.locationArea &&
          description == other.description &&
          name == other.name &&
          item == other.item &&
          imageUser == other.imageUser &&
          space == other.space &&
          address == other.address &&
          buildNum == other.buildNum &&
          buildingSteps == other.buildingSteps &&
          toilet == other.toilet &&
          rentMonthly == other.rentMonthly &&
          rentTime == other.rentTime &&
          bankSafe == other.bankSafe &&
          lettingTime == other.lettingTime &&
          cat == other.cat &&
          type == other.type &&
          price == other.price &&
          rooms == other.rooms;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      image.hashCode ^
      price.hashCode ^
      nameUser.hashCode ^
      emailUser.hashCode ^
      name.hashCode ^
      cat.hashCode ^
      imageUser.hashCode ^
      buildNum.hashCode ^
      buildingSteps.hashCode ^
      toilet.hashCode ^
      rentMonthly.hashCode ^
      rentTime.hashCode ^
      bankSafe.hashCode ^
      lettingTime.hashCode ^
      type.hashCode ^
      locationCountry.hashCode ^
      locationArea.hashCode ^
      description.hashCode ^
      space.hashCode ^
      rooms.hashCode;
}
