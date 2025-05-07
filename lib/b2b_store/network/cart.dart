import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/core/network/api_constant.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';

class CartApiService {
  final DioClient dio;
  const CartApiService({required this.dio});

  Future<AddressesData> addToCart({
    required String token,
    required String cart_id,
    required String variant_id,
    required int quantity,
  }) async {
    try {
      var response = await dio.post(
        APIConstants.ADD_TO_CART + cart_id + '/line-items',
        data: {"variant_id": variant_id, "quantity": quantity, "metadata": {}},
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
      debugPrint("Error in add  to cart  service: $e");
      rethrow;
    }
  }

  Future<CartModel> getAllCartData({
    required String token,
    required String cartId,
  }) async {
    try {
      var response = await dio.get(
        APIConstants.GET_ALL_CART_DATA + cartId,
        options: Options(
          headers: {
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      return CartModel.fromJson(response);
    } catch (e) {
      debugPrint("Error in IOT service: $e");
      rethrow;
    }
  }
}
