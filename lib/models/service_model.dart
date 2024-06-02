import 'package:get/get.dart';

import 'category_model.dart';
import 'media_model.dart';
import 'parent/model.dart';

class EService extends Model {
  @override
  String? id;
  String? name;
  String? description;
  List<Media>? media;
  double? price;
  double? discountPrice;         
  String? priceUnit;
  String? quantityUnit;            
  double? rate;
  int? totalReviews;
  int? available;
  String? duration;
  bool? featured;
  bool? enableBooking;
  bool? isFavorite;
 // List<Media>? mediaG;
  List<Categories>? categories;
  List<Categories>? subCategories;

  EService(
      {this.id,
      this.name,
      this.description,
      this.media,
      this.price,
      this.discountPrice,
      this.priceUnit,
      this.quantityUnit,
   //   this.mediaG,
      this.available,
      this.rate,
      this.totalReviews,
      this.duration,
      this.featured,
      this.enableBooking,
      this.isFavorite,
      this.categories,
      this.subCategories
      });

  EService.fromJson(Map<String, dynamic> json) {

    media = jsonToMediaList(json, 'media');
  //  mediaG =  jsonToMediaListG(json) ;
    price = jsonToDouble(json, 'price');
    discountPrice = jsonToDouble(json, 'discount_price');
    priceUnit = jsonToStr(json, 'price_unit');
    available = jsonToInt(json, 'available');
    rate = jsonToDouble(json, 'rate');
    totalReviews = jsonToInt(json, 'review_count');
    duration = jsonToStr(json, 'duration');
    featured = jsonToBool(json, 'featured');
    enableBooking = jsonToBool(json, 'enable_booking');
    isFavorite = jsonToBool(json, 'is_favorite');
    categories = jsonToList<Categories>(
        json, 'categories', (value) => Categories.fromJson(value));
    subCategories = jsonToList<Categories>(
        json, 'items', (value) => Categories.fromJson(value));
    super.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (available != null) data['available'] = available;
    if (name != null) data['name'] = name;
    if (description != null) data['desc'] = description;
    if (price != null) data['price'] = price;
    if (discountPrice != null) data['discount_price'] = discountPrice;
    if (priceUnit != null) data['price_unit'] = priceUnit;
    if (quantityUnit != null && quantityUnit != 'null') {
      data['quantity_unit'] = quantityUnit;
    }
    if (rate != null) data['rate'] = rate;
    if (totalReviews != null) data['review_count'] = totalReviews;
    if (duration != null) data['duration'] = duration;
    if (featured != null) data['featured'] = featured;
    if (enableBooking != null) data['enable_booking'] = enableBooking;
    if (isFavorite != null) data['is_favorite'] = isFavorite;
    if (categories != null) {
      data['categories'] = categories?.map((v) => v.id).toList();
    }
  //  data['garage_support_cars'] = mediaG;
    data['media'] = media?.map((v) => v.toJson()).toList();

    if (subCategories != null) {
      data['items'] = subCategories?.map((v) => v.toJson()).toList();
    }

    
    return data;
  }

  String get firstImage => media?.first.image ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double? get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double? get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }

  String get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit!.isNotEmpty) {
        return "/" + quantityUnit!.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is EService &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          rate == other.rate &&
          available == other.available &&
          isFavorite == other.isFavorite &&
          media == other.media &&
          enableBooking == other.enableBooking &&
          categories == other.categories &&
          subCategories == other.subCategories ;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      media.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      available.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}
