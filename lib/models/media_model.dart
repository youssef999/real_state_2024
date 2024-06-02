import 'parent/model.dart';

class Media extends Model {
  String? id;
  String? name;
  String? type;
  String? image;
  String? img;
  var ximage;
  Media({String? id, String? img,String? image, String? name, String? type, var ximage}) {
    this.id = id ?? "";
    this.name;
    this.ximage;
    this.img;
    this.type;
    this.image = 'https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2' ?? 'https://drcar.website/api/images/image_default';
  }

  Media.fromJson(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
     // if (jsonMap['media'] != null) img = jsonMap['media'][0]['image'];
      if (jsonMap['name'] != null) name = jsonMap['name'];
      if (jsonMap['image'] != null) image = 'https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';
      if (jsonMap['type'] != null) type = jsonMap['type'];
    } catch (e) {
      image = "https://drcar.website/api/images/image_default";
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map['images[0]'] = ximage;
    map['image'] = img;
    map["type"] = type;
    map['image'] = image;

    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Media &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          img == other.img &&
          ximage == other.id &&
          type == other.type &&
          name == other.name &&
          image == other.image;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      img.hashCode ^
      image.hashCode ^
      ximage.hashCode ^
      type.hashCode;
}
