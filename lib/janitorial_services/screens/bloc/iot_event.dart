import 'package:equatable/equatable.dart';

abstract class IotEvent extends Equatable {
  const IotEvent();
}

class GetIot extends IotEvent {
  final String deviceId;
  final String type;

  const GetIot({
    required this.deviceId,
    required this.type,
  });

  @override
  List<Object?> get props => [deviceId, type];
}

class GetHostDashboardData extends IotEvent {
  final String woloo_id;

  const GetHostDashboardData({required this.woloo_id});

  @override
  List<Object?> get props => [woloo_id];
}
