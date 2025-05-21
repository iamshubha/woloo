import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/order_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/review.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/wishlist.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

class FavoriteService {
  final DioClient dio;
  const FavoriteService({required this.dio});

  Future<Wishlist> getFavorites({required String token}) async {
    try {
      var response = await dio.get(
        "https://staging-store.woloo.in/store/customers/me/wishlists/items?currency_code=inr",
        options: Options(
          headers: {
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      logger.w("Response from getOrderDetails: ${response}");
      return Wishlist.fromJson(response);
    } catch (e) {
      debugPrint("Error in getOrderDetails service: $e");
      rethrow;
    }
  }

  /*
  curl --location 'https://staging-store.woloo.in/store/customers/me/wishlists/items?currency_code=inr' \
--header 'x-publishable-api-key: pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY3Rvcl9pZCI6ImN1c18wMUpUOEJTUDBOWkpCNTlCQ1I0UDJBQ1NNNyIsImFjdG9yX3R5cGUiOiJjdXN0b21lciIsImF1dGhfaWRlbnRpdHlfaWQiOiJhdXRoaWRfMDFKVDhCUVdWRjlYNk5FVlRTNldDWjlWTk4iLCJhcHBfbWV0YWRhdGEiOnsiY3VzdG9tZXJfaWQiOiJjdXNfMDFKVDhCU1AwTlpKQjU5QkNSNFAyQUNTTTcifSwiaWF0IjoxNzQ3NzIyMjA4LCJleHAiOjE3NDc4MDg2MDh9.rOiZQVYpGXPGZaTOr73uUDcibE0v4O95Hh2I9oM5mlQ' \
--header 'Cookie: connect.sid=s%3AjnZrOR1Qge0ljUIWm1djEBUt-dnKgxYl.m8MeL2Fs2HSzAdiGEUbrknG21DfbLhM4G3DxOso3M50'
   */
  Future<Wishlist> addToWishList(
      {required String token, required String variantId}) async {
    try {
      var response = await dio.post(
          "https://staging-store.woloo.in/store/customers/me/wishlists/items",
          options: Options(
            headers: {
              'x-publishable-api-key':
                  'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ),
          data: {
            "variant_id": variantId,
          });
      logger.w("Response from getOrderDetails: ${response}");
      return Wishlist.fromJson(response);
    } catch (e) {
      debugPrint("Error in getOrderDetails service: $e");
      rethrow;
    }
  }

  Future<Review> addReview({
    required String token,
    required String product_id,
    required int rating,
    required String comment,
    required String line_item_id,
  }) async {
    try {
      var response = await dio.post(
          "https://staging-store.woloo.in/store/customers/me/wishlists/items",
          options: Options(
            headers: {
              'x-publishable-api-key':
                  'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ),
          data: {
            "product_id": "$product_id",
            "rating": rating,
            "comment": "$comment",
            "line_item_id": "$line_item_id"
          });
      logger.w("Response from getOrderDetails: ${response}");
      return Review.fromJson(response);
    } catch (e) {
      debugPrint("Error in getOrderDetails service: $e");
      rethrow;
    }
  }
}
