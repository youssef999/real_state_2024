/*
 * Copyright (c) 2020 .
 */
import 'parent/model.dart';
import 'service_model.dart';
import 'user_model.dart';

class Review extends Model {
  String? id;
  double? rate;
  String? review;
  DateTime? createdAt;
  String? idService;
  Users? user;
  EService? eService;

  Review(
      {this.id,
      this.rate,
      this.review,
      this.createdAt,
      this.idService,
      this.user,
      this.eService});

  Review.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    rate = jsonToDouble(json, 'review_value');
    review = jsonToStr(json, 'review');
    idService = jsonToStr(json, 'service_id');
    createdAt =
        jsonToDate(json, 'created_at', defaultValue: DateTime.now().toLocal());
    user = jsonToObject(json, 'user', (v) => Users.fromJson(v));
    eService = jsonToObject(json, 'e_service', (v) => EService.fromJson(v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['review_value'] = this.rate;
    data['review'] = this.review;
    // data['created_at'] = this.createdAt;
    // if (this.user != null) {
    //   data['user_id'] = this.user!.id;
    // }

    data['service_id'] = this.idService;

    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Review &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rate == other.rate &&
          review == other.review &&
          createdAt == other.createdAt &&
          user == other.user &&
          eService == other.eService &&
          idService == other.idService;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      rate.hashCode ^
      review.hashCode ^
      createdAt.hashCode ^
      user.hashCode ^
      idService.hashCode ^
      eService.hashCode;
}
