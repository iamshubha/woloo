import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/core/network/api_constant.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/iotdata_model.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/referral_coins.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

class IotService {
  final DioClient dio;
  const IotService({required this.dio});

  Future<DashboardData> getIotDashBoardData({
    required int facilityId,
    required String type,
  }) async {
    try {
      var response = await dio.post(
        APIConstants.GET_IOT_DASHBOARD_DATA,
        data: {
          // "device_id": "24110012",
          "facility_id": facilityId,
          "type": "last_7_days",
        },
        // data: {"device_id": "AQI-0004", "type": "last_7_days"},
        options:  Options(extra: {"auth": true, "isSupervisor": true }),
      );
      logger.w(response);
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

  Future<ReferralCoins> getReferralCoins({required String woloo_id}) async {
    try {
      var response = await dio.get(
        // APIConstants.GET_IOT_DASHBOARD_DATA,
        "https://staging-api.woloo.in/api/wolooHost/user_coins",
        options: Options(
          headers: {
            'x-woloo-token':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjI2NjksInJvbGVfaWQiOjEzLCJpYXQiOjE3NDMyNTAwMzgsIm5iZiI6MTc0MzI1MDAzOCwiZXhwIjoxNzUxMDI2MDM4LCJpc3MiOiJodHRwczovL3dvbG9vLnZlcmlmaW5vdy5jb20vYXBpL3YxL2xvZ2luIiwic3ViIjoiNjI2NjkiLCJqdGkiOiJBQkNERUZHSElKSyJ9.Py_ksumYDhAAH0IHUbymAJ5HGfjdvE2sLc5l9h2cHXM',
            // 'Content-Type': 'application/json',
          },
        ),
      );
      return ReferralCoins.fromJson(response);
    } catch (e) {
      debugPrint("Error in referral Coins : $e");
      rethrow;
    }
  }
}
