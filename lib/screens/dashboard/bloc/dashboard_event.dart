import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class MarkAttendance extends DashboardEvent {
  final String type;
  final List<double> locations;
  const MarkAttendance({required this.type, required this.locations});

  @override
  List<Object?> get props => [type, locations];
}

class GetTaskTamplates extends DashboardEvent {
  final int janitorId;

  const GetTaskTamplates({required this.janitorId});

  @override
  List<Object?> get props => [janitorId, Random().nextInt(100)];
}

class UpdateStatus extends DashboardEvent {
  final int id;
  final int status;
  const UpdateStatus({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status, Random().nextInt(100)];
}
