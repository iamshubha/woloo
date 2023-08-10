import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model_class.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class ClockInInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class ClockInLoading extends DashboardState {
  final String message;
  const ClockInLoading({required this.message});

  @override
  List<Object> get props => [Random().nextInt(100)];
}

class ClockOutLoading extends DashboardState {
  final String message;
  const ClockOutLoading({required this.message});

  @override
  List<Object> get props => [Random().nextInt(100)];
}

class ClockInSuccessful extends DashboardState {
  @override
  List<Object> get props => [];
}

class ClockOutSuccessful extends DashboardState {
  @override
  List<Object> get props => [Random().nextInt(100)];
}

class ClockInError extends DashboardState {
  final String error;
  const ClockInError({required this.error});

  @override
  List<Object> get props => [error];
}

class ClockOutError extends DashboardState {
  final String error;
  const ClockOutError({required this.error});

  @override
  List<Object> get props => [error];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

class GetDashboardDataSuccess extends DashboardState {
  final List<DashboardModelClass> data;

  const GetDashboardDataSuccess({required this.data});

  @override
  List<Object?> get props => [data, Random().nextInt(100)];
}

class DashboardError extends DashboardState {
  final String error;
  const DashboardError({required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateStatusInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class UpdateStatusLoading extends DashboardState {
  final String message;
  const UpdateStatusLoading({required this.message});

  @override
  List<Object> get props => [Random().nextInt(100)];
}

class UpdateStatusSuccessful extends DashboardState {
  @override
  List<Object> get props => [];
}

class UpdateStatusError extends DashboardState {
  final String error;
  const UpdateStatusError({required this.error});

  @override
  List<Object> get props => [error];
}
