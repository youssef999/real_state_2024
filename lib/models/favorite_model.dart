import 'parent/model.dart';
import 'service_model.dart';

class Favorite extends Model {
  String? id;
  EService? eService;
  String? userId;

  Favorite({this.id, this.eService,  this.userId});

  Favorite.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    eService = jsonToObject(json, 'service', (v) => EService.fromJson(v));
    userId = jsonToStr(json, 'user_id');
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["service_id"] = eService?.id;
    map["user_id"] = userId;

    return map;
  }
}
