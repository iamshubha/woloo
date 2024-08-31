/// id : 12
/// name : "Snehal"
/// mobile : "9284102357"
/// cluster_id : 20
/// cluster_name : "Accenture"
/// pincode : 454565
/// start_time : "7th Aug, 11:00 AM"
/// end_time : "7th Aug, 12:00 PM"
/// janitor_id : 12
/// total_task_count : "1"
/// pending_task_count : "0"
/// isPresent : true

class JanitorListModel {
  JanitorListModel({
    this.id,
    this.name,
    this.mobile,
    this.clusterId,
    this.clusterName,
    this.pincode,
    this.startTime,
    this.endTime,
    this.totalTaskCount,
    this.pendingTaskCount,
    this.isPresent,
    this.shift,
    this.completedTaskCount,
  });

  JanitorListModel.fromJson(dynamic json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    mobile = json['mobile']?.toString();
    clusterId = json['cluster_id']?.toString();
    clusterName = json['cluster_name']?.toString();
    pincode = json['pincode']?.toString();
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    totalTaskCount = json['total']?.toString();
    pendingTaskCount = json['pending']?.toString();
    isPresent = json['isPresent'];
    shift = json['shift']?.toString();
    completedTaskCount = json['completed']?.toString();
  }
  String? id;
  String? name;
  String? mobile;
  String? clusterId;
  String? clusterName;
  String? pincode;
  String? startTime;
  String? endTime;
  String? totalTaskCount;
  String? pendingTaskCount;
  bool? isPresent;
  String? shift;
  String? completedTaskCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['cluster_id'] = clusterId;
    map['cluster_name'] = clusterName;
    map['pincode'] = pincode;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['total'] = totalTaskCount;
    map['pending'] = pendingTaskCount;
    map['isPresent'] = isPresent;
    map['shift'] = shift;
    map['completed'] = completedTaskCount;

    return map;
  }
}
