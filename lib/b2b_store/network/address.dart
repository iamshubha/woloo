import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/core/network/api_constant.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

class AddressService {
  final DioClient dio;
  const AddressService({required this.dio});

  Future<AddAddressResBody> addAddress({
    required AddressReqBody body,
    required String token,
  }) async {
    try {
      var response = await dio.post(
        APIConstants.CREATE_ADDRESS,
        data: body.toJson(),
        options: Options(
          headers: {
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      return AddAddressResBody.fromJson(response);
    } catch (e) {
      debugPrint("Error in IOT service: $e");
      rethrow;
    }
  }

  Future<AddressesData> getAllAddress({
    required String token,
  }) async {
    // logger.w("Token: $token");
    try {
      var response = await dio.get(
        APIConstants.GET_ADDRESS,
        options: Options(
          headers: {
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      return AddressesData.fromJson(response);
    } catch (e) {
      debugPrint("Error in IOT service: $e");
      rethrow;
    }
  }
}
