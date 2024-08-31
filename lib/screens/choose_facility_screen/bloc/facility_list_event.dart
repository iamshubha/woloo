import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:Woloo_Smart_hygiene/screens/task_list/data/model/create_task_model.dart';

abstract class FacilityListEvent extends Equatable {
  const FacilityListEvent();
}

class GetAllFacility extends FacilityListEvent {
  final String janitorId;

  const GetAllFacility({required this.janitorId});

  @override
  List<Object?> get props => [janitorId, Random().nextInt(100)];
}
