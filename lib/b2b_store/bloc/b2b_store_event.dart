import 'package:equatable/equatable.dart';

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
