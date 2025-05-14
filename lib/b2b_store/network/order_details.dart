import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/order_details.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

class OrderDetailsService {
  final DioClient dio;
  const OrderDetailsService({required this.dio});

  Future<OrderDetails> getOrderDetails({required String token}) async {
    try {
      var response = await dio.get(
        "https://staging-store.woloo.in/store/orders",
        options: Options(
          headers: {
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      return OrderDetails.fromJson(response);
    } catch (e) {
      debugPrint("Error in getOrderDetails service: $e");
      rethrow;
    }
  }
}
