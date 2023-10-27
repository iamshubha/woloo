import 'Attendance.dart';

/// message : "Janitor checked_out successfully"
/// attendance : {"last_attendance":{"type":"check_out","location":[19,20]},"last_attendance_date":"2023-10-09T07:26:54.627Z"}

class AttendanceModel {
  AttendanceModel({
    this.message,
    this.attendance,
  });

  AttendanceModel.fromJson(dynamic json) {
    message = json['message'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
  }
  String? message;
  Attendance? attendance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (attendance != null) {
      map['attendance'] = attendance?.toJson();
    }
    return map;
  }
}
