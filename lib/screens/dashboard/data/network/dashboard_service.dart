import 'dart:async';
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

  FutureOr<AttendanceModel> markAttendance({required String type, required List<double> locations}) async {
    try {
      var response = await dio.post(
        APIConstants.ATTENDANCE,
        data: {
          "type": type,
          "location": locations,
        },
        options:
        // Options(
        //     headers: {
        //       "x-woloo-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDE2LCJyb2xlX2lkIjoxLCJpYXQiOjE3MzA4MDc5MzIsImV4cCI6MTczMTQxMjczMn0.cxN_JTM5VPmufui4DLFz2WcDfXmM9-HibkBgEJZpOfk"
        //     },
        //   ),
       Options(extra: {"auth": true}),
      );

      return AttendanceModel.fromJson(response['results']);
    } 
     on  Exception catch (exception) {

      // rethrow;
        throw Exception('Failed to Mark attendace');
      // print(" expetionn $exception");
  // ... // only executed if error is of type Exception
}
    catch (e) {
        throw Exception('Failed to Mark attendace');
    }
  }

  Future<List<DashboardModelClass>> getTasksByJanitorId() async {
    try {
        List<DashboardModelClass> output = [];
      var response = await dio.get(
        APIConstants.GET_ALL_TASK_TAMPLATES,
        options: 
          // Options(
          //   headers: {
          //     "x-woloo-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDE2LCJyb2xlX2lkIjoxLCJpYXQiOjE3MzA4MDc5MzIsImV4cCI6MTczMTQxMjczMn0.cxN_JTM5VPmufui4DLFz2WcDfXmM9-HibkBgEJZpOfk"
          //   },
          // ),
        
        Options(extra: {"auth": true}),
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
        options:
           // Options(
          //   headers: {
          //     "x-woloo-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDE2LCJyb2xlX2lkIjoxLCJpYXQiOjE3MzA4MDc5MzIsImV4cCI6MTczMTQxMjczMn0.cxN_JTM5VPmufui4DLFz2WcDfXmM9-HibkBgEJZpOfk"
          //   },
          // ),
        
        Options(extra: {"auth": true}),
      );
      return AppLaunchModel.fromJson(response['results']);
    } catch (e) {
      throw  Exception('Failed to Mark attendace');
    }
  }
}
