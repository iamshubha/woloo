import 'dart:developer';

import 'package:Woloo_Smart_hygiene/core/model/App_launch_model.dart';
import 'package:dio/dio.dart';
import 'package:Woloo_Smart_hygiene/core/network/api_constant.dart';
import 'package:Woloo_Smart_hygiene/core/network/dio_client.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/data/model/Attendance_model.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/data/model/dashboard_model_class.dart';

class DashboardService {
  final DioClient dio;
  const DashboardService({required this.dio});

  Future<AttendanceModel> markAttendance({required String type, required List<double> locations}) async {
    try {
      var response = await dio.post(
        APIConstants.ATTENDANCE,
        data: {
          "type": type,
          "location": locations,
        },
        options: Options(extra: {"auth": true}),
      );

      return AttendanceModel.fromJson(response['results']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DashboardModelClass>> getTasksByJanitorId() async {
    try {
        List<DashboardModelClass> output = [];
      var response = await dio.get(
        APIConstants.GET_ALL_TASK_TAMPLATES,
        options: Options(extra: {"auth": true}),
      );

    

       print(" janitor task $response");

      for (var item in response['results']) {
        output.add(DashboardModelClass.fromJson(item));
      }

       log("output $output");

      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateStatus({required String id, required String status}) async {
    try {
      var response = await dio.post(
        APIConstants.UPDATE_STATUS,
        data: {
          "id": id,
          "status": status,
        },
        options: Options(extra: {"auth": true}),
      );
       print("update task $response");
      return response['results']?.toString() ?? '';
    } catch (e) {
      rethrow;
    }
  }

  Future<AppLaunchModel> appLaunch() async {
    try {
      var response = await dio.post(
        APIConstants.APP_LAUNCH,
        options: Options(extra: {"auth": true}),
      );
      return AppLaunchModel.fromJson(response['results']);
    } catch (e) {
      rethrow;
    }
  }
}
