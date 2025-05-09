import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/login_flow.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/checkout.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/login_reg_flow.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/product.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

import 'b2b_store_event.dart';
import 'b2b_store_state.dart';

class B2bStoreBloc extends Bloc<B2BStoreEvent, B2BStoreState> {
  final box = GetStorage();
  final LoginFlowService loginFlowService =
      LoginFlowService(dio: GetIt.instance());

  final ProductService _productService = ProductService(dio: GetIt.instance());
  final AddressService _addresstService = AddressService(dio: GetIt.instance());
  final CartApiService _cartService = CartApiService(dio: GetIt.instance());
  final CheckoutApiService _checkoutApiService =
      CheckoutApiService(dio: GetIt.instance());

  var requestId = '';
  late int roleId;
  late int janitorId;

  B2bStoreBloc() : super(B2BStoreInitial()) {
    // on<StoreCustomersReq>(_emailPassRegister);
    on<StoreCustomerLoginReq>(_emailPassLogin);
    on<AddressReq>(_createAddress);
    on<GetAddress>(_getAddress);
    on<GetCartData>(_getCart);
    on<AddToCart>(_addToCart);
    on<Payment>(_proceedToCheckOut);
  }
  _getSelectedAddress() {
    // final addressData = box.read("address");
    // address = Addresses.fromJson(jsonDecode(addressData));
    // // setState(() {});
    // return address;
  }

  FutureOr<void> _emailPassRegister(
    StoreCustomersReq event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      var response = StoreCustomersRes();
      await loginFlowService
          .emailPassRegister(email: event.email, pass: event.pass)
          .then((v) async {
        box.write('email_pass_register_jwt', v);
        response =
            await loginFlowService.createCustomer(email: event.email, token: v);
        box.write('store_customers_id', response.customer!.id);
      });
      debugPrint("requestId $response");
      print(response);
      // emit(B2BStoreSuccess());
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _emailPassLogin(
    StoreCustomerLoginReq event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      ProductCategory categories = ProductCategory();
      TopBrands topBrands = TopBrands();
      ProductCollections productCollections = ProductCollections();

      emit(const B2BStoreLoading(message: "Loading data...sob data"));

      // Login and get token
      final loginToken = await loginFlowService.loginCustomer(
        email: event.email,
        pass: event.pass,
      );
      box.write('login_jwt', loginToken);

      // Get region
      final regionResponse = await _productService.getRegion(token: loginToken);
      box.write('region_id', regionResponse.regions![0].id);
      // Create cart
      await _productService
          .createCart(
              token: loginToken,
              regionId: regionResponse.regions![0].id.toString())
          .then((cartData) {
        box.write('cart_id', cartData.cart!.id);
      });

      // Fetch all required data
      categories =
          await _productService.getProductCategories(token: loginToken);
      topBrands = await _productService.getTopBrands(token: loginToken);
      productCollections =
          await _productService.getProductCollections(token: loginToken);

      // Debug prints
      logger.w(categories);
      logger.w(topBrands);
      logger.w(productCollections);

      // Emit success state
      if (emit.isDone) return;
      emit(B2BStoreSuccess(B2BStoreHomePage(
        productCategory: categories,
        topBrands: topBrands,
        productCollections: productCollections,
      )));
    } catch (e) {
      if (emit.isDone) return;
      emit(B2BStoreError(error: e.toString()));
      logger.w("Error in IOT service: $e");
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _createAddress(
    AddressReq event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      AddAddressResBody response = await _addresstService.addAddress(
          body: event.addressReqBody, token: box.read('login_jwt'));

      debugPrint("requestId $response");
      print(response);
      // emit(B2BStoreSuccess());
      emit(AddAddressSuccess(addAddressResBody: response));
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _getAddress(
    GetAddress event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      AddressesData response =
          await _addresstService.getAllAddress(token: box.read('login_jwt'));

      debugPrint("requestId $response");
      print(response);
      // emit(B2BStoreSuccess());
      emit(GetAddressSuccess(addressesData: response));
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _getCart(
    GetCartData event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const CartLoading(message: "Loading data..."));
      CartModel response = await _cartService.getAllCartData(
          token: box.read('login_jwt'), cartId: box.read('cart_id'));

      debugPrint("requestId $response");
      print(response);

      emit(CartSuccess(cartData: response));
    } catch (e) {
      emit(CartError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _addToCart(
    AddToCart event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      AddToCartResponse response = await _cartService.addToCart(
        token: box.read('login_jwt'),
        cart_id: box.read('cart_id'),
        variant_id: event.variant_id,
        quantity: event.quantity,
      );

      debugPrint("requestId $response");
      print(response);

      emit(AddToCartSuccess(cartData: response));
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _proceedToCheckOut(
    Payment event,
    Emitter<B2BStoreState> emit,
  ) {
    emit(const CartLoading(message: "Proceed to cart"));
    _checkoutApiService
        .shippingOptions(
      cart_id: box.read('cart_id'),
      token: box.read('login_jwt'),
    )
        .then((onValue) {
      _checkoutApiService
          .shippingOptionsCalculate(
        shipping_option: onValue.shippingOptions!.first.id,
        token: box.read('login_jwt'),
        cart_id: box.read('cart_id'),
      )
          .then((v) {
        logger.w(v);
        _checkoutApiService
            .shippingMethods(
                shipping_option: onValue.shippingOptions!.first.id,
                token: box.read('login_jwt'),
                cart_id: box.read('cart_id'))
            .then((v) {
          logger.w(v.cart);
          _checkoutApiService
              .paymentProviders(
                  token: box.read('login_jwt'),
                  region_id: box.read('region_id'))
              .then((v) {
            logger.w(v.paymentProviders);
            _checkoutApiService
                .paymentCollections(
                    token: box.read('login_jwt'), cart_id: box.read('cart_id'))
                .then((e) {
              logger.w(e.paymentCollection);
              _checkoutApiService
                  .paymentSessions(
                      token: box.read('login_jwt'),
                      pay_col: e.paymentCollection!.id,
                      provider_id: v.paymentProviders![0].id)
                  .then((val) {
                logger.w(val);
                _checkoutApiService
                    .completeVendor(
                        token: box.read('login_jwt'),
                        cart_id: box.read('cart_id'))
                    .then((val) {
                  logger.w(val);
                  final orderId = val.order!.parentOrder!.id;
                  _checkoutApiService
                      .placeOrder(
                          token: box.read('login_jwt'), order_id: orderId)
                      .then((orderVal) {
                    logger.w(orderVal);
                  });
                });
              });
            });
          });
        });
      });
    });
    emit(CartSuccess(cartData: CartModel()));
  }
}

class B2BStoreHomePage {
  ProductCategory productCategory;
  TopBrands topBrands;
  ProductCollections productCollections;

  B2BStoreHomePage({
    required this.productCategory,
    required this.topBrands,
    required this.productCollections,
  });
}
