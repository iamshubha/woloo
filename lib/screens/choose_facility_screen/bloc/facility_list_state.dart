import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:Woloo_Smart_hygiene/screens/choose_facility_screen/data/model/Facility_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/cluster_screen/data/model/Cluster_model.dart';
import 'package:Woloo_Smart_hygiene/screens/issue_list_screen/data/model/Issue_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/data/model/Janitor_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/task_list/data/model/task_list_model.dart';

abstract class FacilityListState extends Equatable {
  const FacilityListState();
}

class FacilityListInitial extends FacilityListState {
  @override
  List<Object> get props => [];
}

class FacilityListLoading extends FacilityListState {
  @override
  List<Object> get props => [];
}

class FacilityListSuccess extends FacilityListState {
  final List<FacilityListModel> data;

  const FacilityListSuccess({required this.data});

  @override
  List<Object?> get props => [data, Random().nextInt(100)];
}

class FacilityListError extends FacilityListState {
  final String error;
  const FacilityListError({required this.error});

  @override
  List<Object> get props => [error];
}
