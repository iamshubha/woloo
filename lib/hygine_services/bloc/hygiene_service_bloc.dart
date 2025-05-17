import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/payment_provider.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/checkout.dart';
import 'package:woloo_smart_hygiene/hygine_services/network/hygiene_service.dart';

import 'hygiene_service_event.dart';
import 'hygiene_service_state.dart';

class HygieneServiceBloc
    extends Bloc<HygieneServiceEvent, HygieneServiceState> {
  final box = GetStorage();
  final HygieneServiceApi hygieneServiceApi =
      HygieneServiceApi(dio: GetIt.instance());
  final CartApiService _cartService = CartApiService(dio: GetIt.instance());

  final CheckoutApiService _checkoutApiService =
      CheckoutApiService(dio: GetIt.instance());

  HygieneServiceBloc() : super(HygieneServiceInitial()) {
    on<HygieneServiceReq>(_getAllHygieneData);
    on<HygieneServiceReqById>(_getHygieneDataById);
    on<AddToCart>(_addToCart);
  }

  FutureOr<void> _getAllHygieneData(
    HygieneServiceReq event,
    Emitter<HygieneServiceState> emit,
  ) async {
    try {
      emit(const HygieneServiceLoading(message: "Loading data..."));
      final regionResponse =
          await hygieneServiceApi.getRegion(token: box.read('login_jwt'));
      box.write('region_id', regionResponse.regions![0].id);
      // await hygieneServiceApi.createCart(
      //     token: box.read('login_jwt'),
      //     regionId: regionResponse.regions![0].id.toString());
      final response = await hygieneServiceApi.getAllHygieneData();
      debugPrint("requestId $response");
      print(response);
      // emit(HygieneServiceSuccess());
      emit(HygieneServiceSuccess(dashboardData: response));
    } catch (e) {
      emit(HygieneServiceError(error: e.toString()));
      debugPrint("Error in _getAllHygieneData service: $e");
    }
  }

  FutureOr<void> _getHygieneDataById(
    HygieneServiceReqById event,
    Emitter<HygieneServiceState> emit,
  ) async {
    try {
      emit(const HygieneServiceLoading(message: "Loading data..."));
      final response = await hygieneServiceApi.getHygieneDataById(
          productId: event.productId);

      debugPrint("requestId $response");
      print(response);
      // emit(HygieneServiceSuccess());
      emit(HygieneServiceProductSuccess(dashboardData: response));
    } catch (e) {
      emit(HygieneServiceError(error: e.toString()));
      debugPrint("Error in _getAllHygieneData service: $e");
    }
  }

  FutureOr<void> _addToCart(
    AddToCart event,
    Emitter<HygieneServiceState> emit,
  ) async {
    try {
      //TODO:Add event
      emit(const HygieneServiceLoading(message: "Loading data..."));
      AddToCartResponse res = await hygieneServiceApi.addToCart(
        service_date: event.service_date,
        service_time: event.service_time,
        service_area: event.service_area,
        token: box.read('login_jwt'),
        cart_id: box.read('cart_id'),
        variant_id: event.variant_id,
        quantity: event.quantity,
      );

      //TODO:Add event
      // emit(CartSuccess(cartData: response));
      emit(HygieneServiceCartSuccess());
    } catch (e) {
      //TODO:Add event
      // emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in ATC service: $e");
      emit(HygieneServiceError(error: e.toString()));
    }
  }

  FutureOr<void> _proceedToCheckOut(
    Payment event,
    Emitter<HygieneServiceState> emit,
  ) async {
    //TODO:Add event
    // emit(const CartLoading(message: "Proceed to cart"));
    try {
      final shippingOptions = await _checkoutApiService.shippingOptions(
        cart_id: box.read('cart_id'),
        token: box.read('login_jwt'),
      );

      // final shippingOptionsCalculate =
      //     await _checkoutApiService.shippingOptionsCalculate(
      //   shipping_option: shippingOptions.shippingOptions!.first.id,
      //   token: box.read('login_jwt'),
      //   cart_id: box.read('cart_id'),
      // );

      final shippingMethods = await _checkoutApiService.shippingMethods(
          // TODO:
          /*
                    
                    curl --location -g '{{base-url}}/store/carts/{{cart-id}}/add-shipping-methods' \
            --header 'Content-Type: application/json' \
            --header 'x-publishable-api-key: {{publishable-api-key}}' \
            --header 'Authorization: Bearer {{customer-token}}' \
            --data '// Staging
            {
                "options": [
                    {
                        "id": "so_01JV4P2DWP2QJD9QCZSDJ0RPJN"
                    },
                    {
                        "id": "so_01JV4RA9FFC3203JWJN0RAB53J"
                    }
                ]
            }'



        */
          shipping_option: shippingOptions.shippingOptions!.first.id,
          token: box.read('login_jwt'),
          cart_id: box.read('cart_id'));

      final paymentProviders = await _checkoutApiService.paymentProviders(
          token: box.read('login_jwt'), region_id: box.read('region_id'));

      PaymentCollection paymentCollections =
          await _checkoutApiService.paymentCollections(
              token: box.read('login_jwt'), cart_id: box.read('cart_id'));

      final paymentSessions = await _checkoutApiService.paymentSessions(
          token: box.read('login_jwt'),
          pay_col: paymentCollections.paymentCollection!.id,
          provider_id: paymentProviders.paymentProviders![0].id);

      final orderId =
          paymentSessions.paymentCollection!.paymentSessions![0].data!.id ??
              "0";

      //TODO:Add event
      // emit(LetsTryState(
      //   order_id: orderId,
      //   total_price:
      //       paymentSessions.paymentCollection!.paymentSessions![0].amount ?? 0,
      // ));
    } catch (e) {
      //TODO:Add event
      // emit(CartError(error: e.toString()));
    }
  }
}
