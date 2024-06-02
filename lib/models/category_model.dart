import 'media_model.dart';
import 'parent/model.dart';
import 'service_model.dart';

class Categories extends Model {
  @override
  String? id;
  String? name;
  String? description;
  int? type;
  Media? image;
  bool? featured;
  List<Categories>? subCategories;
  List<EService>? eServices;

  Categories(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.image,
      this.featured,
      this.subCategories,
      this.eServices});

  Categories.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    image = jsonToMedia(json, 'image');
    featured =true;
    // jsonToBool(json, 'featured');
name = 'first';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['desc'] = description;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Categories &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type &&
          description == other.description &&
          image == other.image &&
          featured == other.featured &&
          subCategories == other.subCategories &&
          eServices == other.eServices;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      type.hashCode ^
      featured.hashCode ^
      subCategories.hashCode ^
      eServices.hashCode;
}
