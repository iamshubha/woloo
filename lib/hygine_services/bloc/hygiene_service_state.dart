import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/hygine_services/model/hygiene_services.dart';

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

class HygieneServiceProductSuccess extends HygieneServiceState {
  final Product dashboardData;
  const HygieneServiceProductSuccess({required this.dashboardData});
  @override
  List<Object> get props => [dashboardData];
}

class HygieneServiceCartSuccess extends HygieneServiceState {
  const HygieneServiceCartSuccess();
  @override
  List<Object> get props => [];
}
