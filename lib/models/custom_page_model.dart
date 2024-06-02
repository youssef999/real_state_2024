import 'parent/model.dart';

class CustomPage extends Model {
  late String? id;
  late String? title;
  late String? content;
  late DateTime? updatedAt;

  CustomPage({this.id, this.title, this.content, this.updatedAt});

  CustomPage.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);

    updatedAt = jsonToDate(json, 'updated_at');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is CustomPage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      updatedAt.hashCode;
}
