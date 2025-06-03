import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/region.dart';
import 'package:woloo_smart_hygiene/core/network/api_constant.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

class ProductService {
  final DioClient dio;
  const ProductService({required this.dio});

  Future<RegionsModel> getRegion({
    required String token,
  }) async {
    try {
      var response = await dio.get(
        APIConstants.GET_REGIONS,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return RegionsModel.fromJson(response);
    } catch (e) {
      debugPrint("error $e");
      rethrow;
    }
  }

  Future<CartModel> createCart({
    required String token,
    required String regionId,
  }) async {
    try {
      var response = await dio.post(
        APIConstants.CREATE_CART,
        data: {
          "region_id": regionId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return CartModel.fromJson(response);
    } catch (e) {
      debugPrint("error $e");
      rethrow;
    }
  }

  Future<ProductCategory> getProductCategories({
    required String token,
  }) async {
    try {
      var response = await dio.get(
        APIConstants.GET_PRODUCT_CATEGORIES,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return ProductCategory.fromJson(response);
    } catch (e) {
      debugPrint("error $e");
      rethrow;
    }
  }

  Future<TopBrands> getTopBrands({
    required String token,
  }) async {
    try {
      var response = await dio.get(
        APIConstants.TOP_BRANDS,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return TopBrands.fromJson(response);
    } catch (e) {
      debugPrint("error $e");
      rethrow;
    }
  }

  Future<ProductCollections> getProductCollections({
    required String token,
  }) async {
    try {
      var response = await dio.get(
        APIConstants.PRODUCT_COLLECTIONS,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return ProductCollections.fromJson(response);
    } catch (e) {
      debugPrint("error $e");
      rethrow;
    }
  }

  Future<ProductCollections> getProductCollectionsById({
    required String token,
    required String id,
  }) async {
    try {
      var response = await dio.get(
        "https://staging-store.woloo.in/store/products?fields=*variants.calculated_price&collection_id=$id",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-publishable-api-key':
                'pk_03b79693816aae4cb87568dc50b7efaa48e0d51b201040f46ef4528839078f08',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return ProductCollections.fromJson(response);
    } catch (e) {
      debugPrint("error $e");
      rethrow;
    }
  }
}



/**
 1. Create Cart
{
 @POST("store/carts")
    fun getCartCreated(@Body request : CartRequest): Call<CartResponse>

 @SerializedName("region_id")

2) Get Categories: 
 @GET("store/product-categories")
    fun getCategoriesList(): Call<CategoriesListResponse>
}

3. ) Get Brands - 
 @GET("store/collections")
    fun getCollections(
        @Query("fields") fields: String
    ): Call<CollectionsListResponse>


4)   @GET("store/products")
    fun getCollectionWiseProducts(
        @Query("fields") price: String,
        @Query("collection_id") fields: String  {collection_id = top brand --> brand_id}

    ): Call<ProductListResponse>


5)@GET("store/products")
    fun getCategoryWiseProducts(
        @Query("fields") price: String,
        @Query("category_id") fields: String
    ): Call<ProductListResponse>

6) @GET("store/products")
    fun getProductWithPriceList(
        @Query("fields") fields: String,
        @Query("region_id") region_id: String
    ): Call<ProductListResponse>


           { fields =    *variants.calculated_price}

    #_________________________________________________#

7) @GET("store/products")
    fun getProductWithPriceListWithQuery(
        @Query("fields") fields: String,
        @Query("region_id") region_id: String,
        @Query("q") q: String
    ): Call<ProductListResponse>
 */



/*
for region id

@GET("store/regions")
    fun getRegionsList(): Call<RegionListResponse>
*/