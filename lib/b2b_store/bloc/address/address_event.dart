import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class LoadAddresses extends AddressEvent {}

class SelectAddress extends AddressEvent {
  final Addresses address;

  const SelectAddress(this.address);

  @override
  List<Object> get props => [address];
}

class AddNewAddress extends AddressEvent {
  final Addresses address;

  const AddNewAddress(this.address);

  @override
  List<Object> get props => [address];
}

class RemoveAddress extends AddressEvent {
  final String addressId;

  const RemoveAddress(this.addressId);

  @override
  List<Object> get props => [addressId];
}
