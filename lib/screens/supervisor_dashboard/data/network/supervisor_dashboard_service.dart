import 'package:dio/dio.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model_class.dart';
import 'package:janitor/screens/janitor_screen/data/model/Reassign_janitor_model.dart';
import 'package:janitor/screens/supervisor_dashboard/model/Supervisor_model_dashboard.dart';

class SupervisorDashboardService {
  final DioClient dio;
  const SupervisorDashboardService({required this.dio});

  Future<List<SupervisorModelDashboard>> getSupervisorDashboardData() async {
    try {
      var response = await dio.get(APIConstants.GET_SUPERVISOR_DASHBOARD_DATA,
          options: Options(
            extra: {"auth": true},
          ));

      List<SupervisorModelDashboard> output = [];
      for (var item in response['results']) {
        output.add(SupervisorModelDashboard.fromJson(item));
      }

      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateStatus({required String id, required int status}) async {
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

  Future<ReassignJanitorModel> reAssignTaskToJanitor({
    required List<String> id,
    required String janitor_id,
  }) async {
    print("Data" + id.toString());
    try {
      var response = await dio.put(
        APIConstants.RE_ASSIGN_TASK,
        data: {
          "id": id,
          "janitor_id": janitor_id,
        },
        options: Options(extra: {"auth": true}),
      );

      return ReassignJanitorModel.fromJson(response['results']);
    } catch (e) {
      rethrow;
    }
  }
}
