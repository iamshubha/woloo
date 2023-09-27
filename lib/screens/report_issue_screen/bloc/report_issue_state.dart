import 'package:equatable/equatable.dart';
import 'package:janitor/screens/report_issue_screen/data/model/Cluster_dropdown_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/Janitor_dropdown_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/report_issue_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/task_names_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/facility_dropdown_model.dart';
import 'package:janitor/screens/task_list/data/model/task_list_model.dart';

abstract class ReportIssueState extends Equatable {
  const ReportIssueState();
}

class ReportIssueInitial extends ReportIssueState {
  @override
  List<Object> get props => [];
}

class GetClustersDropdownLoading extends ReportIssueState {
  @override
  List<Object> get props => [];
}

class GetClustersDropdownSuccess extends ReportIssueState {
  final List<ClusterDropdownModel> data;

  const GetClustersDropdownSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetClustersDropdownError extends ReportIssueState {
  final String error;
  const GetClustersDropdownError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetFacilityDropdownLoading extends ReportIssueState {
  @override
  List<Object> get props => [];
}

class GetFacilityDropdownSuccess extends ReportIssueState {
  final List<FacilityDropdownModel> data;

  const GetFacilityDropdownSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetFacilityDropdownError extends ReportIssueState {
  final String error;
  const GetFacilityDropdownError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetTasksDropdownLoading extends ReportIssueState {
  @override
  List<Object> get props => [];
}

class GetTasksDropdownSuccess extends ReportIssueState {
  final List<TaskNamesModels> data;

  const GetTasksDropdownSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetTasksDropdownError extends ReportIssueState {
  final String error;
  const GetTasksDropdownError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetJanitorsDropdownLoading extends ReportIssueState {
  @override
  List<Object> get props => [];
}

class GetJanitorsDropdownSuccess extends ReportIssueState {
  final List<JanitorDropdownModel> data;

  const GetJanitorsDropdownSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetJanitorsDropdownError extends ReportIssueState {
  final String error;
  const GetJanitorsDropdownError({required this.error});

  @override
  List<Object> get props => [error];
}

class ReportIssueLoading extends ReportIssueState {
  @override
  List<Object> get props => [];
}

class ReportIssueSuccess extends ReportIssueState {
  ReportIssueModel data;
  ReportIssueSuccess({required this.data});
  @override
  List<Object?> get props => [data];
}

class ReportIssueError extends ReportIssueState {
  final String error;
  const ReportIssueError({required this.error});

  @override
  List<Object> get props => [error];
}
