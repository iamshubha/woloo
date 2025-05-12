import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/hygine_services/model/hygiene_services.dart';
import 'package:woloo_smart_hygiene/janitorial_services/model/host_dashboard_screen.dart';

abstract class HygieneServiceState extends Equatable {
  const HygieneServiceState();
}

class HygieneServiceInitial extends HygieneServiceState {
  @override
  List<Object> get props => [];
}

class HygieneServiceLoading extends HygieneServiceState {
  final String message;
  const HygieneServiceLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class HygieneServiceError extends HygieneServiceState {
  final String error;
  const HygieneServiceError({required this.error});

  @override
  List<Object> get props => [error];
}

class HygieneServiceSuccess extends HygieneServiceState {
  final HygieneService dashboardData;
  const HygieneServiceSuccess({required this.dashboardData});
  @override
  List<Object> get props => [dashboardData];
}
