import 'package:dio/dio.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model_class.dart';

class DashboardService {
  final DioClient dio;
  const DashboardService({required this.dio});

  Future<String> markAttendance(
      {required String type, required List<double> locations}) async {
    try {
      var response = await dio.post(
        APIConstants.ATTENDANCE,
        data: {
          "type": type,
          "location": locations,
        },
        options: Options(extra: {"auth": true}),
      );

      return response['results'].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DashboardModelClass>> getTasksByJanitorId() async {
    try {
      var response = await dio.get(
        APIConstants.GET_ALL_TASK_TAMPLATES,
        options: Options(extra: {"auth": true}),
      );

      List<DashboardModelClass> output = [];
      for (var item in response['results']) {
        output.add(DashboardModelClass.fromJson(item));
      }

      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateStatus(
      {required String id, required String status}) async {
    try {
      var response = await dio.post(
        APIConstants.UPDATE_STATUS,
        data: {
          "id": id,
          "status": status,
        },
        options: Options(extra: {"auth": true}),
      );

      return response['results'].toString();
    } catch (e) {
      rethrow;
    }
  }
}
