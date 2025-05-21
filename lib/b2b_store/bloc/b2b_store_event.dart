import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';

abstract class B2BStoreEvent extends Equatable {
  const B2BStoreEvent();
}

class StoreCustomersReq extends B2BStoreEvent {
  final String email;
  final String pass;

  const StoreCustomersReq({
    required this.email,
    required this.pass,
  });

  @override
  List<Object?> get props => [email, pass];
}

class StoreCustomerLoginReq extends B2BStoreEvent {
  final String email;
  final String pass;

  const StoreCustomerLoginReq({
    required this.email,
    required this.pass,
  });

  @override
  List<Object?> get props => [email, pass];
}

class AddRemoveItemReq extends B2BStoreEvent {
  final String itemId;
  final int count;
  const AddRemoveItemReq({
    required this.itemId,
    required this.count,
  });

  @override
  List<Object?> get props => [itemId, count];
}

class DeleteItemReq extends B2BStoreEvent {
  final String itemId;
  const DeleteItemReq({required this.itemId});
  @override
  List<Object?> get props => [itemId];
}

class GetIot extends B2BStoreEvent {
  final String deviceId;
  final String type;

  const GetIot({
    required this.deviceId,
    required this.type,
  });

  @override
  List<Object?> get props => [deviceId, type];
}

class GetHostDashboardData extends B2BStoreEvent {
  final String woloo_id;

  const GetHostDashboardData({required this.woloo_id});

  @override
  List<Object?> get props => [woloo_id];
}

class AddressReq extends B2BStoreEvent {
  final AddressReqBody addressReqBody;

  const AddressReq({required this.addressReqBody});

  @override
  List<Object?> get props => [addressReqBody];
}

class GetAddress extends B2BStoreEvent {
  const GetAddress();

  @override
  List<Object?> get props => [];
}

class SelectAddress extends B2BStoreEvent {
  const SelectAddress(this.addresses);
  final Addresses addresses;
  @override
  List<Object?> get props => [addresses];
}

class GetCartData extends B2BStoreEvent {
  const GetCartData();

  @override
  List<Object?> get props => [];
}

class Payment extends B2BStoreEvent {
  const Payment();

  @override
  List<Object?> get props => [];
}

class ProceedToShip extends B2BStoreEvent {
  const ProceedToShip();

  @override
  List<Object?> get props => [];
}

class PlaceOrder extends B2BStoreEvent {
  final String? order_id;
  const PlaceOrder({required this.order_id});

  @override
  List<Object?> get props => [];
}

class LetsTry extends B2BStoreEvent {
  const LetsTry();
  @override
  List<Object?> get props => [];
}

class AddRemoveId extends B2BStoreEvent {
  const AddRemoveId();
  @override
  List<Object?> get props => [];
}

class AddToCart extends B2BStoreEvent {
  final String? variant_id;
  final int quantity;

  const AddToCart({
    required this.variant_id,
    required this.quantity,
  });

  @override
  List<Object?> get props => [variant_id, quantity];
}

// class

class OrderDetailsEvent extends B2BStoreEvent {
  const OrderDetailsEvent();
  @override
  List<Object?> get props => [];
}

class WishlistEvent extends B2BStoreEvent {
  const WishlistEvent();
  @override
  List<Object?> get props => [];
}

class AddToWishList extends B2BStoreEvent {
  final String variantId;

  const AddToWishList({required this.variantId});

  @override
  List<Object?> get props => [variantId];
}

class ReviewEvent extends B2BStoreEvent {
  final String product_id;
  final int rating;
  final String comment;
  final String line_item_id;
  const ReviewEvent(
      {required this.product_id,
      required this.rating,
      required this.comment,
      required this.line_item_id});
  @override
  List<Object?> get props => [product_id, rating, comment, line_item_id];
}
