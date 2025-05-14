import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/order.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/order_details.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/host_dashboard_screen.dart';

abstract class B2BStoreState extends Equatable {
  const B2BStoreState();
}

class B2BStoreInitial extends B2BStoreState {
  @override
  List<Object> get props => [];
}

class B2BStoreLoading extends B2BStoreState {
  final String message;
  const B2BStoreLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class B2BStoreError extends B2BStoreState {
  final String error;
  const B2BStoreError({required this.error});

  @override
  List<Object> get props => [error];
}

class B2BStoreSuccess extends B2BStoreState {
  final B2BStoreHomePage dashboardData;
  const B2BStoreSuccess(this.dashboardData);
  @override
  List<Object> get props => [dashboardData];
}

class HostDashboardSuccess extends B2BStoreState {
  final HostDashboardData dashboardData;
  const HostDashboardSuccess({required this.dashboardData});
  @override
  List<Object> get props => [dashboardData];
}

class AddAddressSuccess extends B2BStoreState {
  final AddAddressResBody addAddressResBody;
  const AddAddressSuccess({required this.addAddressResBody});
  @override
  List<Object> get props => [addAddressResBody];
}

class GetAddressSuccess extends B2BStoreState {
  final AddressesData addressesData;
  const GetAddressSuccess({required this.addressesData});
  @override
  List<Object> get props => [addressesData];
}

class CartInitial extends B2BStoreState {
  @override
  List<Object> get props => [];
}

class CartLoading extends B2BStoreState {
  final String message;
  const CartLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class CartError extends B2BStoreState {
  final String error;
  const CartError({required this.error});

  @override
  List<Object> get props => [error];
}

class AddToCartSuccess extends B2BStoreState {
  final AddToCartResponse cartData;
  const AddToCartSuccess({required this.cartData});
  @override
  List<Object> get props => [cartData];
}

class CartSuccess extends B2BStoreState {
  final CartModel cartData;
  const CartSuccess({required this.cartData});
  @override
  List<Object> get props => [cartData];
}

class ProceedCart extends B2BStoreState {
  final CartModel cartData;
  const ProceedCart({required this.cartData});
  @override
  List<Object> get props => [];
}

class AddressGet extends B2BStoreState {
  final Addresses addressesData;
  const AddressGet({required this.addressesData});
  @override
  List<Object> get props => [addressesData];
}

class AddressSet extends B2BStoreState {
  final Addresses message;
  const AddressSet({required this.message});

  @override
  List<Object> get props => [message];
}

class PaymentSuccess extends B2BStoreState {
  final CompleteVendor completeVendor;
  PaymentSuccess({required this.completeVendor});

  @override
  List<Object> get props => [];
}

class LetsTryState extends B2BStoreState {
  final String order_id;
  final int total_price;
  const LetsTryState({
    required this.order_id,
    required this.total_price,
  });
  @override
  List<Object> get props => [order_id];
}

class OrderDetailsSuccess extends B2BStoreState {
  final OrderDetails orderDetailsData;
  const OrderDetailsSuccess({required this.orderDetailsData});
  @override
  List<Object> get props => [orderDetailsData];
}

class OrderDetailsLoading extends B2BStoreState {
  final String message;
  const OrderDetailsLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDetailsError extends B2BStoreState {
  final String error;
  const OrderDetailsError({required this.error});

  @override
  List<Object> get props => [error];
}
