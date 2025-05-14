import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/address/address_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/address/address_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<LoadAddresses>(_onLoadAddresses);
    on<SelectAddress>(_onSelectAddress);
    on<AddNewAddress>(_onAddNewAddress);
    on<RemoveAddress>(_onRemoveAddress);
  }

  void _onLoadAddresses(LoadAddresses event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading());
      // TODO: Implement loading addresses from API
      // For now, we'll use an empty list
      emit(const AddressLoaded(addresses: []));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  void _onSelectAddress(SelectAddress event, Emitter<AddressState> emit) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;
      emit(currentState.copyWith(selectedAddress: event.address));
    }
  }

  void _onAddNewAddress(AddNewAddress event, Emitter<AddressState> emit) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;
      final updatedAddresses = List<Addresses>.from(currentState.addresses)
        ..add(event.address);
      emit(currentState.copyWith(addresses: updatedAddresses));
    }
  }

  void _onRemoveAddress(RemoveAddress event, Emitter<AddressState> emit) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;
      final updatedAddresses = currentState.addresses
          .where((address) => address.id != event.addressId)
          .toList();

      // If the removed address was selected, clear the selection
      Addresses? selectedAddress = currentState.selectedAddress;
      if (selectedAddress?.id == event.addressId) {
        selectedAddress = null;
      }

      emit(currentState.copyWith(
        addresses: updatedAddresses,
        selectedAddress: selectedAddress,
      ));
    }
  }
}
