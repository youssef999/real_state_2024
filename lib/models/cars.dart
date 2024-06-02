class Cars {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Cars({this.id, this.name, this.createdAt, this.updatedAt});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Cars &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;
  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode;
}
