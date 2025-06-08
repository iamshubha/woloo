import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/login_flow.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/order_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/review.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/wishlist.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/checkout.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/favorite.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/login_reg_flow.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/order_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/network/product.dart';
import 'package:woloo_smart_hygiene/hygine_services/view/address_notifier.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

import 'b2b_store_event.dart';
import 'b2b_store_state.dart';

class B2bStoreBloc extends Bloc<B2BStoreEvent, B2BStoreState> {
  final box = GetStorage();
  List<Map<String, String>> favIds = [];
  final LoginFlowService loginFlowService =
      LoginFlowService(dio: GetIt.instance());

  final ProductService _productService = ProductService(dio: GetIt.instance());
  final AddressService _addresstService = AddressService(dio: GetIt.instance());
  final CartApiService _cartService = CartApiService(dio: GetIt.instance());
  final CheckoutApiService _checkoutApiService =
      CheckoutApiService(dio: GetIt.instance());
  final OrderDetailsService _orderDetailsService =
      OrderDetailsService(dio: GetIt.instance());
  final FavoriteService _favoriteService =
      FavoriteService(dio: GetIt.instance());

  var requestId = '';
  late int roleId;
  late int janitorId;

  B2bStoreBloc() : super(B2BStoreInitial()) {
    // on<StoreCustomersReq>(_emailPassRegister);
    on<StoreCustomerLoginReq>(_emailPassLogin);
    on<AddressReq>(_createAddress);
    on<GetAddress>(_getAddress);
    on<UpdateAddressReq>(_updateAddress);
    on<GetCartData>(_getCart);
    on<AddToCart>(_addToCart);
    on<ProceedToShip>(_proceedToSheep);
    on<Payment>(_proceedToCheckOut);
    on<AddRemoveItemReq>(_addRemoveItems);
    on<PlaceOrder>(_placeOrder);
    on<DeleteItemReq>(_deleteItem);

    on<OrderDetailsEvent>(_getOrderDetails);
    on<SelectAddress>(_selectAddress);
    on<WishlistEvent>(_getWishlist);
    on<AddToWishList>(_addWishlist);
    on<ReviewEvent>(_addReview);
    on<DeleteAddress>(_deleteAddress);
    on<RemoveWishList>(_removeFromWishlist);
    on<GetOrderReview>(getProductReviews);
    on<Refresh>(_refresh);
    on<RestockSubscriptionsEvent>(restockSubscriptions);
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

      emit(const B2BStoreLoading(message: "Loading data..."));

      // Login and get token
      final loginToken = await loginFlowService.loginCustomer(
        email: event.email,
        pass: event.pass,
      );
      box.write('login_jwt', loginToken);

      // Get region
      final regionResponse = await _productService.getRegion(token: loginToken);
      box.write('region_id', regionResponse.regions![0].id);

      await _productService
          .createCart(
              token: loginToken,
              regionId: regionResponse.regions![0].id.toString())
          .then((cartData) {
        box.write('cart_id', cartData.cart.id);
      });
      CartModel cartModel = await _cartService.getAllCartData(
          token: box.read('login_jwt'), cartId: box.read('cart_id'));

      // Fetch all required data
      categories =
          await _productService.getProductCategories(token: loginToken);
      topBrands = await _productService.getTopBrands(token: loginToken);
      productCollections =
          await _productService.getProductCollections(token: loginToken);

      final fav = await _favoriteService.getFavorites(token: loginToken);

      favIds = getCommonProductIds(fav, productCollections);
      final address = box.read('address');
      // Debug prints
      selectedAddress.value = address != null
          ? Addresses.fromJson(jsonDecode(address))
          : Addresses();
      // Emit success state
      if (emit.isDone) return;
      emit(B2BStoreSuccess(B2BStoreHomePage(
          productCategory: categories,
          topBrands: topBrands,
          productCollections: productCollections,
          cartData: cartModel,
          fav: fav)));
    } catch (e) {
      if (emit.isDone) return;
      emit(B2BStoreError(error: e.toString()));
      logger.w("Error in IOT service: $e");
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _refresh(
    Refresh event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      ProductCategory categories = ProductCategory();
      TopBrands topBrands = TopBrands();
      ProductCollections productCollections = ProductCollections();

      emit(const B2BStoreLoading(message: "Loading data..."));

      // // Login and get token
      // final loginToken = await loginFlowService.loginCustomer(
      //   email: event.email,
      //   pass: event.pass,
      // );
      final loginToken = box.read('login_jwt');

      // Get region
      final regionResponse = await _productService.getRegion(token: loginToken);
      box.write('region_id', regionResponse.regions![0].id);

      CartModel cartModel = await _cartService.getAllCartData(
          token: box.read('login_jwt'), cartId: box.read('cart_id'));

      // Fetch all required data
      categories =
          await _productService.getProductCategories(token: loginToken);
      topBrands = await _productService.getTopBrands(token: loginToken);
      if (event.id != null) {
        productCollections = await _productService.getProductCollectionsById(
            token: loginToken, id: event.id!);
      } else {
        productCollections =
            await _productService.getProductCollections(token: loginToken);
      }

      final fav = await _favoriteService.getFavorites(token: loginToken);

      favIds = getCommonProductIds(fav, productCollections);

      // Emit success state
      if (emit.isDone) return;
      emit(B2BStoreSuccess(B2BStoreHomePage(
          productCategory: categories,
          topBrands: topBrands,
          productCollections: productCollections,
          cartData: cartModel,
          fav: fav)));
    } catch (e) {
      if (emit.isDone) return;
      emit(B2BStoreError(error: e.toString()));
      logger.e("Error in IOT service: $e");
    }
  }

  FutureOr<void> _createAddress(
    AddressReq event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      AddAddressResBody response = await _addresstService.addAddress(
          body: AddAddressReqBody(
            first_name: event.first_name,
            last_name: event.last_name,
            address_1: event.address_1,
            city: event.city,
            phone_number: event.phone_number,
            postal_code: event.pincode,
            province: event.province,
            address_name: event.address_name,
          ),
          token: box.read('login_jwt'));

      debugPrint("requestId $response");
      print(response);
      // emit(B2BStoreSuccess());
      emit(AddAddressSuccess(addAddressResBody: response));
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in IOT service: $e");
    }
  }

  FutureOr<void> _updateAddress(
    UpdateAddressReq event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      AddAddressResBody response = await _addresstService.updateAddress(
          body: event.addressReqBody,
          token: box.read('login_jwt'),
          addressId: event.addressId);

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

  FutureOr<void> _deleteAddress(
      DeleteAddress event, Emitter<B2BStoreState> emit) async {
    emit(const PostAddressLoading(message: "Loading...."));
    try {
      final val = await _addresstService.deleteAddress(
          addressId: event.addressId, token: box.read('login_jwt'));

      AddressesData response =
          await _addresstService.getAllAddress(token: box.read('login_jwt'));

      debugPrint("requestId $response");
      // print(response);
      // emit(B2BStoreSuccess());
      emit(GetAddressSuccess(addressesData: response));
    } catch (e) {
      logger.e("Address Delete Bloc Issue: $e");
    }
  }

  FutureOr<void> _selectAddress(
      SelectAddress event, Emitter<B2BStoreState> emit) async {
    emit(const PostAddressLoading(message: "Loading...."));
    try {
      await _addresstService.selectAddress(
          cartId: box.read('cart_id'),
          shippingAddress: event.addresses,
          token: box.read('login_jwt'));
      emit(const PostAddressSuccess());
    } catch (e) {
      logger.w("Error in Select Address: $e");
    }
  }

  List<Map<String, String>> getCommonProductIds(
      Wishlist wishlist, ProductCollections productCollections) {
    List<Map<String, String>> wishlistProductIds = wishlist.wishlist?.items
            ?.map((item) => <String, String>{
                  item.productVariant?.productId ?? '': item.id ?? ''
                })
            .toList() ??
        [];
    List<String> collectionProductIds = productCollections.products
        .map((product) => product.id)
        .whereType<String>()
        .toList();

    return wishlistProductIds
        .where((id) => collectionProductIds.contains(id.entries.first.key))
        .toList();
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
      debugPrint("Error in GetCart service: $e");
    }
  }

  FutureOr<void> _addRemoveItems(
    AddRemoveItemReq event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const CartLoading(message: "Loading data..."));
      CartModel response;
      if (event.count == 0) {
        await _cartService.deleteItem(
            itemId: event.itemId,
            token: box.read('login_jwt'),
            cartId: box.read('cart_id'));
        response = await _cartService.getAllCartData(
            token: box.read('login_jwt'), cartId: box.read('cart_id'));
      } else {
        response = await _cartService.addOrRemoveItem(
            itemId: event.itemId,
            count: event.count,
            token: box.read('login_jwt'),
            cartId: box.read('cart_id'));
      }

      emit(CartSuccess(cartData: response));
    } catch (e) {
      emit(CartError(error: e.toString()));
      logger.w("Error in bloc: $e");
      rethrow;
    }
  }

  FutureOr<void> _addToCart(
    AddToCart event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const B2BStoreLoading(message: "Loading data..."));
      emit(const CartLoading(message: "Loading data..."));
      AddToCartResponse res = await _cartService.addToCart(
        token: box.read('login_jwt'),
        cart_id: box.read('cart_id'),
        variant_id: event.variant_id,
        quantity: event.quantity,
      );

      // debugPrint("requestId $response");
      // print("Response Id: $response");
      CartModel response = await _cartService.getAllCartData(
          token: box.read('login_jwt'), cartId: box.read('cart_id'));

      debugPrint("requestId $response");
      print(response);

      emit(CartSuccess(cartData: response));
      // emit(AddToCartSuccess(cartData: response));
    } catch (e) {
      emit(B2BStoreError(error: e.toString()));
      debugPrint("Error in ATC service: $e");
    }
  }

  FutureOr<void> _proceedToSheep(
    ProceedToShip event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const CartLoading(message: "Proceed to cart"));
    try {
      //call on checkout button click then add delivery total at cart bottom sheet

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
          shipping_option:
              // shippingOptions.shippingOptions!.first.id,
              shippingOptions.shippingOptions!
                  .map<Map<String, dynamic>>((option) => {'id': option.id})
                  .toList(),
          token: box.read('login_jwt'),
          cart_id: box.read('cart_id'));

      emit(ReadyToShip(
        shippingDetails: shippingMethods,
      ) //completeVendor.orderSet.orders[0].items[0].total)
          );
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  FutureOr<void> _proceedToCheckOut(
    Payment event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const CartLoading(message: "Proceed to cart"));
    try {
      //call on checkout button click then add delivery total at cart bottom sheet
      {
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
            shipping_option:
                // shippingOptions.shippingOptions!.first.id,
                shippingOptions.shippingOptions!
                    .map<Map<String, dynamic>>((option) => {'id': option.id})
                    .toList(),
            token: box.read('login_jwt'),
            cart_id: box.read('cart_id'));
      }
      final paymentProviders = await _checkoutApiService.paymentProviders(
          token: box.read('login_jwt'), region_id: box.read('region_id'));

      final paymentCollections = await _checkoutApiService.paymentCollections(
          token: box.read('login_jwt'), cart_id: box.read('cart_id'));

      final paymentSessions = await _checkoutApiService.paymentSessions(
          token: box.read('login_jwt'),
          pay_col: paymentCollections, //.paymentCollection?.id,
          provider_id: paymentProviders.paymentProviders[0].id);

      // final completeVendor = await _checkoutApiService.completeVendor(
      //     token: box.read('login_jwt'), cart_id: box.read('cart_id'));

      final orderId =
          paymentSessions.paymentCollection?.paymentSessions?[0].data?.id ??
              "0";

      // final placeOrder = await _checkoutApiService.placeOrder(
      //     token: box.read('login_jwt'), order_id: orderId);

      // emit(CartSuccess(cartData: CartModel()));
      emit(LetsTryState(
        orderId: orderId,
        totalPrice:
            paymentSessions.paymentCollection?.paymentSessions?[0].amount ?? 0,
      ) //completeVendor.orderSet.orders[0].items[0].total)
          );
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  FutureOr<void> _placeOrder(
    PlaceOrder event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const CartLoading(message: "Proceed to cart"));
    try {
      // final placeOrder = await _checkoutApiService.placeOrder(
      //     cart_id: box.read('cart_id'),
      //     token: box.read('login_jwt'),
      //     order_id: event.order_id);
      final completeVendor = await _checkoutApiService.completeVendor(
          token: box.read('login_jwt'), cart_id: box.read('cart_id'));
      await _productService
          .createCart(
              token: box.read('login_jwt'), regionId: box.read('region_id'))
          .then((cartData) {
        box.write('cart_id', cartData.cart.id);
      });
      emit(PaymentSuccess(completeVendor: completeVendor));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  FutureOr<void> _deleteItem(
      DeleteItemReq event, Emitter<B2BStoreState> emit) async {
    emit(const CartLoading(message: "Proceed to cart"));
    try {
      await _cartService.deleteItem(
          itemId: event.itemId,
          token: box.read('login_jwt'),
          cartId: box.read('cart_id'));
      // logger.w(response);
      CartModel response = await _cartService.getAllCartData(
          token: box.read('login_jwt'), cartId: box.read('cart_id'));

      emit(CartSuccess(cartData: response));
    } catch (e) {
      logger.e("Error in delete Item Bloc: $e");
      emit(CartError(error: e.toString()));
    }
  }

  FutureOr<void> _getOrderDetails(
    OrderDetailsEvent event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const OrderDetailsLoading(message: 'Loading order details...'));
    try {
      OrderDetails orderDetails = await _orderDetailsService.getOrderDetails(
          token: box.read('login_jwt'));
      emit(OrderDetailsSuccess(orderDetailsData: orderDetails));
    } catch (e) {
      debugPrint("Error in getOrderDetails service: $e");
      emit(OrderDetailsError(error: e.toString()));
    }
  }

  FutureOr<void> _getWishlist(
    WishlistEvent event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const WishlistLoading(message: 'Loading wishlist...'));
    try {
      Wishlist wishlist =
          await _favoriteService.getFavorites(token: box.read('login_jwt'));
      final productCollections = await _productService.getProductCollections(
          token: box.read('login_jwt'));
      favIds = getCommonProductIds(wishlist, productCollections);
      emit(WishlistSuccess(wishlistData: wishlist));
    } catch (e) {
      debugPrint("Error in getFavorites service: $e");
      emit(WishlistError(error: e.toString()));
    }
  }

  FutureOr<void> _addWishlist(
    AddToWishList event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const WishlistLoading(message: 'Loading wishlist...'));
    try {
      final wishlist = await _favoriteService.addToWishList(
          token: box.read('login_jwt'), variantId: event.variantId);
      emit(WishlistSuccess(wishlistData: wishlist));
    } catch (e) {
      debugPrint("Error in getFavorites service: $e");
      emit(WishlistError(error: e.toString()));
    }
  }

  FutureOr<void> _removeFromWishlist(
      RemoveWishList event, Emitter<B2BStoreState> emit) async {
    emit(const WishlistLoading(message: 'Loading wishlist...'));
    try {
      Wishlist wishlist = await _favoriteService.removeItemFromWishlist(
          box.read('login_jwt'), event.itemId);
      emit(WishlistSuccess(wishlistData: wishlist));
    } catch (e) {
      debugPrint("Error in getFavorites service: $e");
      emit(WishlistError(error: e.toString()));
    }
  }

  FutureOr<void> _addReview(
    ReviewEvent event,
    Emitter<B2BStoreState> emit,
  ) async {
    emit(const WishlistLoading(message: 'Loading wishlist...'));
    try {
      Review review = await _favoriteService.addReview(
          token: box.read('login_jwt'),
          product_id: event.product_id,
          rating: event.rating,
          comment: event.comment,
          line_item_id: event.line_item_id);
      // emit(WishlistSuccess(wishlistData: wishlist));
    } catch (e) {
      debugPrint("Error in getFavorites service: $e");
      // emit(WishlistError(error: e.toString()));
    }
  }

  FutureOr<void> getProductReviews(
    GetOrderReview getOrderReview,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const ReviewLoading(message: 'Loading product reviews...'));
      final response = await _orderDetailsService.getOrderReviews(
          token: box.read('login_jwt'), productId: getOrderReview.productId);
      // logger.w(response);
      emit(CustomerReviewSuccess(customerReview: response));
    } catch (e) {
      logger.e("Error in getProductReviews: $e");
    }
  }

  FutureOr<void> restockSubscriptions(
    RestockSubscriptionsEvent event,
    Emitter<B2BStoreState> emit,
  ) async {
    try {
      emit(const RestockSubscriptionsLoading(
          message: 'Restocking subscriptions...'));
      final response = await _productService.restockSubscriptions(
          token: box.read('login_jwt'),
          variantId: event.variantId,
          phoneNumber: event.phoneNumber);
      emit(RestockSubscriptionsSuccess(
        restockSubscriptions: response,
      ));
      logger.w("Restock Subscriptions Response: $response");
    } catch (e) {
      emit(RestockSubscriptionsError(error: e.toString()));
      logger.e("Error in restockSubscriptions: $e");
    }
  }
}

class B2BStoreHomePage {
  ProductCategory productCategory;
  TopBrands topBrands;
  ProductCollections productCollections;
  CartModel cartData;
  Wishlist fav;
  B2BStoreHomePage(
      {required this.productCategory,
      required this.topBrands,
      required this.productCollections,
      required this.cartData,
      required this.fav});
}
