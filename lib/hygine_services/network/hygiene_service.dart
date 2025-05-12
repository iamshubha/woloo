import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/hygine_services/model/hygiene_services.dart';

class HygieneServiceApi {
  final DioClient dio;
  const HygieneServiceApi({required this.dio});

  Future<HygieneService> getAllHygieneData() async {
    try {
      var response = await dio.get(
        "https://staging-store.woloo.in/store/products?fields=*variants.calculated_price&region_id=reg_01JPH693TAM20TXZEJNBJ5QBV4",
        options: Options(
          headers: {
            'x-publishable-api-key':
                'pk_67ce4e90f35529f44006d2a95b330dbabbe576e43d3fd06021ca656ee00806cf',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      return HygieneService.fromJson(response);
    } catch (e) {
      debugPrint("Error in IOT service: $e");
      rethrow;
    }
  }
}
