import 'dart:convert';

import '../media_model.dart';

abstract class Model {
  String? id;

  bool get hasData => id != null;

  void fromJson(Map<String, dynamic> json) {
    id = jsonToStr(json, 'id');
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return toJson().toString();
  }



  String jsonToStr(Map<String, dynamic> json, String attribute,
      {String defaultValue = ''}) {
    try {
      return json != null
          ? json[attribute] != null
              ? json[attribute].toString()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }
  
  String jsonToStrW(Map<String, dynamic> json, String attribute,String att2,
      {String defaultValue = ''}) {
    try {
      return json != null
          ? json[attribute][att2] != null
              ? json[attribute][att2].toString()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }
  String jsonToStrS(Map<String, dynamic> json, String attribute, String att2,
      {String defaultValue = ''}) {
    try {
      return json != null
          ? json[attribute][att2] != null
              ? json[attribute][att2].toString()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }



  DateTime? jsonToDate(Map<String, dynamic> json, String attribute,
      {DateTime? defaultValue}) {
    try {
      return json != null
          ? json[attribute] != null
              ? DateTime.parse(json[attribute]).toLocal()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  DateTime? jsonToDateD(
      Map<String, dynamic> json, String attribute, String att2,
      {DateTime? defaultValue}) {
    try {
      return json != null
          ? json[attribute][att2] != null
              ? DateTime.parse(json[attribute][att2]).toLocal()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  dynamic jsonToMap(Map<String, dynamic> json, String attribute,
      {Map<dynamic, dynamic>? defaultValue}) {
    try {
      return json != null
          ? json[attribute] != null
              ? jsonDecode(json[attribute])
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  int jsonToInt(Map<String, dynamic> json, String attribute,
      {int defaultValue = 0}) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is int) {
          return json[attribute];
        }
        return int.parse(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  double jsonToDouble(Map<String, dynamic> json, String attribute,
      {int decimal = 2, double defaultValue = 0.0}) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is double) {
          return double.parse(json[attribute].toStringAsFixed(decimal));
        }
        if (json[attribute] is int) {
          return double.parse(
              json[attribute].toDouble().toStringAsFixed(decimal));
        }
        return double.parse(
            double.tryParse(json[attribute])!.toStringAsFixed(decimal));
      }
      return defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  double jsonToDoubleT(Map<String, dynamic> json, String attribute, String att2,
      {int decimal = 2, double defaultValue = 0.0}) {
    try {
      if (json[attribute][att2] != null) {
        if (json[attribute][att2] is double) {
          return double.parse(json[attribute][att2].toStringAsFixed(decimal));
        }
        if (json[attribute][att2] is int) {
          return double.parse(
              json[attribute][att2].toDouble().toStringAsFixed(decimal));
        }
        return double.parse(
            double.tryParse(json[attribute][att2])!.toStringAsFixed(decimal));
      }
      return defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  bool jsonToBool(Map<String?, dynamic> json, String attribute,
      {bool defaultValue = false}) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is bool) {
          return json[attribute];
        } else if ((json[attribute] is String) &&
            !['0', '', 'false'].contains(json[attribute])) {
          return true;
        } else if ((json[attribute] is int) &&
            ![0, -1].contains(json[attribute])) {
          return true;
        }
        return false;
      }
      return defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  Media jsonToMediaJ(Map<String, dynamic> json, String attribute) {
    try {
      Media media = Media();
      if (json['media'] != null && (json['media']).length > 0) {
        media = Media.fromJson(json['media']);
      }
      return media;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  Media jsonToMedia(Map<String, dynamic> json, String attribute) {
    try {
      Media media = Media();
      if (json['media'] != null && (json['media']).length > 0) {
        media = Media.fromJson(json['media'][0]);
      }
      return media;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }

  List<Media> jsonToMediaList(Map<String, dynamic> json, String attribute) {
    try {
      List<Media> medias = [Media()];
      if (json['media'] != null && (json['media']).length > 0) {
        medias = List.from(json['media'])
            .map((element) => Media.fromJson(element))
            .toSet()
            .toList();
      }
      return medias;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }
  //   List<Media> jsonToMediaListG(Map<String, dynamic> json) {
  //   try {
  //     List<Media> medias = [new Media()];
  //     if (json['provider']['user']['garage_support_cars'] != null && (json['provider']['user']['garage_support_cars']).length > 0) {
  //       medias = List.from(json['provider']['user']['garage_support_cars'])
  //           .map((element) => Media.fromJson(element))
  //           .toSet()
  //           .toList();
  //     }
  //     return medias;
  //   } catch (e) {
  //     throw Exception(
  //         'Error while parsing ' + 'Media Garage' + '[' + e.toString() + ']');
  //   }
  // }

  List<T> jsonArrayToList<T>(Map<String, dynamic> json, List<String> attribute,
      T Function(Map<String, dynamic>) callback) {
    String attribute0 = attribute
        .firstWhere((element) => (json[element] != null), orElse: () => '');
    return jsonToList(json, attribute0, callback);
  }

  List<T> jsonToList<T>(Map<String, dynamic> json, String attribute,
      T Function(Map<String, dynamic>) callback) {
    try {
      List<T> list = <T>[];
      if (json[attribute] != null &&
          json[attribute] is List &&
          json[attribute].length > 0) {
        json[attribute].forEach((v) {
          if (v is Map<String, dynamic>) {
            list.add(callback(v));
          }
        });
      }
      return list;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  List<T> jsonToListW<T>(Map<String, dynamic> json, String attribute,
      String att2, T Function(Map<String, dynamic>) callback) {
    try {
      List<T> list = <T>[];
      if (json[attribute][att2] != null &&
          json[attribute][att2] is List &&
          json[attribute][att2].length > 0) {
        json[attribute][att2].forEach((v) {
          if (v is Map<String, dynamic>) {
            list.add(callback(v));
          }
        });
      }
      return list;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  T? jsonToObject<T>(Map<String, dynamic> json, String attribute,
      T Function(Map<String, dynamic>) callback,
      {T? defaultValue}) {
    try {
      if (json[attribute] != null && json[attribute] is Map<String, dynamic>) {
        return callback(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception(
          'Error while parsing $attribute[$e]');
    }
  }
}

T? jsonToObjectE<T>(Map<String, dynamic> json, String attribute, String att2,
    T Function(Map<String, dynamic>) callback,
    {T? defaultValue}) {
  try {
    if (json[attribute][att2] != null &&
        json[attribute][att2] is Map<String, dynamic>) {
      return callback(json[attribute][att2]);
    }
    return defaultValue;
  } catch (e) {
    throw Exception(
        'Error while parsing proverd $attribute[$e]');
  }
}
