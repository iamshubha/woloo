import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/host_dashboard_screen.dart';

import '../../model/iotdata_model.dart';

abstract class IotState extends Equatable {
  const IotState();
}

class IotInitial extends IotState {
  @override
  List<Object> get props => [];
}

class IotLoading extends IotState {
  final String message;
  const IotLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class IotError extends IotState {
  final String error;
  const IotError({required this.error});

  @override
  List<Object> get props => [error];
}

class IotSuccess extends IotState {
  final DashboardData dashboardData;
  const IotSuccess({required this.dashboardData});
  @override
  List<Object> get props => [dashboardData];
}

class HostDashboardSuccess extends IotState {
  final HostDashboardData dashboardData;
  const HostDashboardSuccess({required this.dashboardData});
  @override
  List<Object> get props => [dashboardData];
}
