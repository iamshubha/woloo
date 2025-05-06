import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
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
