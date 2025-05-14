import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Addresses> addresses;
  final Addresses? selectedAddress;

  const AddressLoaded({
    required this.addresses,
    this.selectedAddress,
  });

  @override
  List<Object?> get props => [addresses, selectedAddress];

  AddressLoaded copyWith({
    List<Addresses>? addresses,
    Addresses? selectedAddress,
  }) {
    return AddressLoaded(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}

class AddressError extends AddressState {
  final String message;

  const AddressError(this.message);

  @override
  List<Object> get props => [message];
}
