// To parse this JSON data, do
//
//     final dashbaordModel = dashbaordModelFromJson(jsonString);

import 'dart:convert';

DashbaordModel dashbaordModelFromJson(String str) => DashbaordModel.fromJson(json.decode(str));

String dashbaordModelToJson(DashbaordModel data) => json.encode(data.toJson());

class DashbaordModel {
    Results? results;
    bool? success;

    DashbaordModel({
 this.results,
 this.success,
    });

    factory DashbaordModel.fromJson(Map<String, dynamic> json) => DashbaordModel(
        results: Results.fromJson(json["results"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "results": results!.toJson(),
        "success": success,
    };
}

class Results {
    JanitorEfficiency? janitorEfficiency;
    TaskStatusDistribution? taskStatusDistribution;

    Results({
 this.janitorEfficiency,
 this.taskStatusDistribution,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        janitorEfficiency: JanitorEfficiency.fromJson(json["Janitor_efficiency"]),
        taskStatusDistribution: TaskStatusDistribution.fromJson(json["Task_status_distribution"]),
    );

    Map<String, dynamic> toJson() => {
        "Janitor_efficiency": janitorEfficiency!.toJson(),
        "Task_status_distribution": taskStatusDistribution!.toJson(),
    };
}

class JanitorEfficiency {
    List<dynamic>? totaltask;
    List<dynamic>? category;
    String? unit;
    List<dynamic>? closedtask;

    JanitorEfficiency({
 this.totaltask,
 this.category,
 this.unit,
 this.closedtask,
    });

    factory JanitorEfficiency.fromJson(Map<String, dynamic> json) => JanitorEfficiency(
        totaltask: List<dynamic>.from(json["totaltask"].map((x) => x)),
        category: List<dynamic>.from(json["category"].map((x) => x)),
        unit: json["unit"],
        closedtask: List<dynamic>.from(json["closedtask"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "totaltask": List<dynamic>.from(totaltask!.map((x) => x)),
        "category": List<dynamic>.from(category!.map((x) => x)),
        "unit": unit,
        "closedtask": List<dynamic>.from(closedtask!.map((x) => x)),
    };
}

class TaskStatusDistribution {
    String? facility;
    String? pendingCount;
    String? acceptedCount;
    String? ongoingCount;
    String? completedCount;
    String? completedPercentage;

    TaskStatusDistribution({
 this.facility,
 this.pendingCount,
 this.acceptedCount,
 this.ongoingCount,
 this.completedCount,
 this.completedPercentage,
    });

    factory TaskStatusDistribution.fromJson(Map<String, dynamic> json) => TaskStatusDistribution(
        facility: json["facility"],
        pendingCount: json["pending_count"],
        acceptedCount: json["accepted_count"],
        ongoingCount: json["ongoing_count"],
        completedCount: json["completed_count"],
        completedPercentage: json["completed_percentage"],
    );

    Map<String, dynamic> toJson() => {
        "facility": facility,
        "pending_count": pendingCount,
        "accepted_count": acceptedCount,
        "ongoing_count": ongoingCount,
        "completed_count": completedCount,
        "completed_percentage": completedPercentage,
    };
}
