import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';

abstract class ReportIssueEvent extends Equatable {
  const ReportIssueEvent();
}

class GetAllClustersDropdown extends ReportIssueEvent {
  const GetAllClustersDropdown();

  @override
  List<Object?> get props => [];
}

class GetAllFacilityDropdown extends ReportIssueEvent {
  final int clusterId;

  const GetAllFacilityDropdown({required this.clusterId});

  @override
  List<Object?> get props => [];
}

class GetAllTasksDropdown extends ReportIssueEvent {
  const GetAllTasksDropdown();

  @override
  List<Object?> get props => [];
}

class GetAllJanitorsDropdown extends ReportIssueEvent {
  final int clusterId;

  const GetAllJanitorsDropdown({required this.clusterId});

  @override
  List<Object?> get props => [];
}

class ReportIssue extends ReportIssueEvent {
  final String template_id;
  final File task_images;
  final int facility_id;
  final int janitor_id;
  final String description;

  const ReportIssue(
      {required this.template_id,
      required this.facility_id,
      required this.janitor_id,
      required this.description,
      required this.task_images});

  @override
  List<Object?> get props =>
      [template_id, facility_id, janitor_id, description, task_images];
}
