

class FacilityDropdownModel {
  FacilityDropdownModel({
    this.id,
    this.facilityName,
    this.locationName
    // this.requiredTime
  });

  FacilityDropdownModel.fromJson(dynamic json) {
    id = json["id"];
    facilityName = json["facility_name"];
    locationName = json["location_name"];
    // requiredTime = json['required_time'];

  }
  int? id;
  String? facilityName;
  String? locationName;
  // int? requiredTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['facility_name'] = facilityName;
    map['location_name'] = locationName;
    // map['required_time'] = requiredTime;
    return map;
  }
}