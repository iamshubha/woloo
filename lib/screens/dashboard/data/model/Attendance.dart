import 'LastAttendance.dart';

/// last_attendance : {"type":"check_out","location":[19,20]}
/// last_attendance_date : "2023-10-09T07:26:54.627Z"

class Attendance {
  Attendance({
    this.lastAttendance,
    this.lastAttendanceDate,
  });

  Attendance.fromJson(dynamic json) {
    lastAttendance = json['last_attendance'] != null
        ? LastAttendance.fromJson(json['last_attendance'])
        : null;
    lastAttendanceDate = json['last_attendance_date'];
  }
  LastAttendance? lastAttendance;
  String? lastAttendanceDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (lastAttendance != null) {
      map['last_attendance'] = lastAttendance?.toJson();
    }
    map['last_attendance_date'] = lastAttendanceDate;
    return map;
  }
}
