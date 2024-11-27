/// cluster_id : 20
/// cluster_name : "Accenture"
/// pincode : 454565
/// janitor_id : 12
/// janitor_name : "Snehal"
/// completed_task : 2
/// pending_task : 0
/// total_task : 2

class ClusterModel {
  ClusterModel({
    this.clusterId,
    this.clusterName,
    this.pincode,
    this.janitorId,
    this.janitorName,
    this.completedTask,
    this.pendingTask,
    this.totalTask,
  });

  ClusterModel.fromJson(dynamic json) {
    clusterId = json['cluster_id'];
    clusterName = json['cluster_name'];
    pincode = json['pincode']  ;
    janitorId = json['janitor_id'];
    janitorName = json['janitor_name'];
    completedTask = json['completed_task'];
    pendingTask = json['pending_task'];
    totalTask = json['total_task'];
  }
  int? clusterId;
  String? clusterName;
  int? pincode;
  int? janitorId;
  String? janitorName;
  int? completedTask;
  int? pendingTask;
  int? totalTask;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cluster_id'] = clusterId;
    map['cluster_name'] = clusterName;
    map['pincode'] = pincode ;
    map['janitor_id'] = janitorId;
    map['janitor_name'] = janitorName;
    map['completed_task'] = completedTask;
    map['pending_task'] = pendingTask;
    map['total_task'] = totalTask;
    return map;
  }
}
