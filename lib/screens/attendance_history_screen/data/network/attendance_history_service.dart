import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Attendance_history_model.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Month_list_model.dart';
import 'package:dio/dio.dart';
import 'package:Woloo_Smart_hygiene/core/network/api_constant.dart';
import 'package:Woloo_Smart_hygiene/core/network/dio_client.dart';

class AttendanceHistoryService {
  final DioClient dio;
  const AttendanceHistoryService({required this.dio});

  Future<List<AttendanceHistoryModel>> getAllHistory(
      {required String month, required String year}) async {
    try {
      var response = await dio.post(
        APIConstants.ATTENDANCE_HISTORY_LIST,
        data: {
          "month": month,
          "year": year,
        },
        options: Options(extra: {"auth": true}),
      );
      List<AttendanceHistoryModel> output = [];
      for (var item in response['results']) {
        output.add(AttendanceHistoryModel.fromJson(item));
      }
      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MonthListModel>> getAllMonths() async {
    try {
      var response = await dio.get(
        APIConstants.MONTH_LIST,
        options: Options(extra: {"auth": true}),
      );
      List<MonthListModel> output = [];
      for (var item in response['results']) {
        output.add(MonthListModel.fromJson(item));
      }
      return output;
    } catch (e) {
      rethrow;
    }
  }
}
