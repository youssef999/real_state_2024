import 'parent/model.dart';

class BookingStatus extends Model {
  String? id;
  String? statusID;
  int? order;
  String? statusName;

  BookingStatus({this.id, this.statusID});

  BookingStatus.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    order = jsonToInt(json, 'order');
    statusName = jsonToStr(json, 'status');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = statusID;
    data['order'] = order;
    return data;
  }
}
