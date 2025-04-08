
class TaskDropdownModel {
  TaskDropdownModel({
    this.id,
    this.facilityName,
    this.requiredTime
  });

  TaskDropdownModel.fromJson(dynamic json) {
    id = json['id'];
    facilityName = json['task_name'];
    requiredTime = json['required_time'];

  }
  int? id;
  String? facilityName;
  int? requiredTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['facility_name'] = facilityName;
    map['required_time'] = requiredTime;
    return map;
  }
}