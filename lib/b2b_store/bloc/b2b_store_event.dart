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
