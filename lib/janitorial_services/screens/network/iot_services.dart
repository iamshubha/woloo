
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/core/network/api_constant.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/iotdata_model.dart';

class IotService {
  final DioClient dio;
  const IotService({required this.dio});

  Future<DashboardData> getIotDashBoardData({
    required String deviceId,
    required String type,
  }) async {
    try {
      var response = await dio.post(
        APIConstants.GET_IOT_DASHBOARD_DATA,
        data: {
          "device_id": "24110012",
          // "location_id": 34,
          "type": "today",
        },
        options: Options(
          headers: {
            'x-woloo-token':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nzc5LCJyb2xlX2lkIjoxLCJpYXQiOjE3NDU0ODc1NTksIm5iZiI6MTc0NTQ4NzU1OSwiZXhwIjoxNzUzMjYzNTU5LCJpc3MiOiJodHRwczovL3dvbG9vLnZlcmlmaW5vdy5jb20vYXBpL3YxL2xvZ2luIiwic3ViIjoiNzc5IiwianRpIjoiQUJDREVGR0hJSksifQ.YCUGwVO-gXHMgXCaRGsoW9UB4mb7tiwGLD_8v9wb-Cg',
            // 'Content-Type': 'application/json',
          },
        ),
      );

      return DashboardData.fromJson(response);
    } catch (e) {
      debugPrint("Error in IOT service: $e");
      rethrow;
    }
  }

  Future<HostDashboardData> gethostDashboardData(
      {required String woloo_id}) async {
    try {
      var response = await dio.get(
        // APIConstants.GET_IOT_DASHBOARD_DATA,
        "https://staging-api.woloo.in/api/wolooHost/hostDashboardData?woloo_id=19108",
        options: Options(
          headers: {
            'x-woloo-token':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nzc5LCJyb2xlX2lkIjoxLCJpYXQiOjE3NDU4NDAyMDMsIm5iZiI6MTc0NTg0MDIwMywiZXhwIjoxNzUzNjE2MjAzLCJpc3MiOiJodHRwczovL3dvbG9vLnZlcmlmaW5vdy5jb20vYXBpL3YxL2xvZ2luIiwic3ViIjoiNzc5IiwianRpIjoiQUJDREVGR0hJSksifQ.o9gOU-DPZLiWFFM_WH6WqzBNEsj2gsfQFONd6CfSUTA',
            // 'Content-Type': 'application/json',
          },
        ),
      );

      return HostDashboardData.fromJson(response);
    } catch (e) {
      debugPrint("Error in IOT service: $e");
      rethrow;
    }
  }
}
