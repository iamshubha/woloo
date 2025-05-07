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
import 'package:woloo_smart_hygiene/b2b_store/network/login_reg_flow.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/product.dart';
import 'b2b_store_event.dart';
import 'b2b_store_state.dart';

class B2bStoreBloc extends Bloc<B2BStoreEvent, B2BStoreState> {
  final box = GetStorage();
  final LoginFlowService loginFlowService =
      LoginFlowService(dio: GetIt.instance());

  final ProductService _productService = ProductService(dio: GetIt.instance());
  final AddressService _addresstService = AddressService(dio: GetIt.instance());
  final CartApiService _cartService = CartApiService(dio: GetIt.instance());

  var requestId = '';
  late int roleId;
  late int janitorId;

  B2bStoreBloc() : super(B2BStoreInitial()) {
    // on<StoreCustomersReq>(_emailPassRegister);
    on<StoreCustomerLoginReq>(_emailPassLogin);
    on<AddressReq>(_createAddress);
    on<GetAddress>(_getAddress);
    on<GetCartData>(_getCart);
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
      ProductCategory _categories = ProductCategory();
      TopBrands _topBrands = TopBrands();
      ProductCollections _productCollections = ProductCollections();

      emit(const B2BStoreLoading(message: "Loading data...sob data"));

      // Login and get token
      final loginToken = await loginFlowService.loginCustomer(
        email: event.email,
        pass: event.pass,
      );
      box.write('login_jwt', loginToken);

      // Get region
      final regionResponse = await _productService.getRegion(token: loginToken);

      // Create cart
      await _productService
          .createCart(
              token: loginToken,
              regionId: regionResponse.regions![0].id.toString())
          .then((cartData) {
        box.write('cart_id', cartData.cart!.id);
      });

      // Fetch all required data
      _categories =
          await _productService.getProductCategories(token: loginToken);
      _topBrands = await _productService.getTopBrands(token: loginToken);
      _productCollections =
          await _productService.getProductCollections(token: loginToken);

      // Debug prints
      print(_categories);
      print(_topBrands);
      print(_productCollections);

      // Emit success state
      if (emit.isDone) return;
      emit(B2BStoreSuccess(B2BStoreHomePage(
        productCategory: _categories,
        topBrands: _topBrands,
        productCollections: _productCollections,
      )));
    } catch (e) {
      if (emit.isDone) return;
      emit(B2BStoreError(error: e.toString()));
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
      emit(const B2BStoreLoading(message: "Loading data..."));
      CartModel response = await _cartService.getAllCartData(
          token: box.read('login_jwt'), cartId: box.read('cart_id'));

      debugPrint("requestId $response");
      print(response);

      // emit(CartSuccess());
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
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
